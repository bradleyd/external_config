defmodule ExternalConfig do
  defmodule LoadError do
    defexception [:file, :error]

    def message(%LoadError{file: file, error: error}) do
      "Could not load config: #{Path.relative_to_cwd(file)}\n    " <>
      "#{Exception.format_banner(:error, error)}"
    end
  end

  @moduledoc false

  defmacro __using__(_) do
    quote do
      import ExternalConfig, only: [config: 2, config: 3]
      {:ok, agent} = Agent.start_link(fn -> [] end)
      var!(config_agent, ExternalConfig) = agent
    end
  end

  defmacro config(app, opts) do
    quote do
      ExternalConfig.agent_merge(var!(config_agent, ExternalConfig), [{unquote(app), unquote(opts)}])
    end
  end

  defmacro config(app, key, opts) do
    quote do
      ExternalConfig.agent_merge(var!(config_agent, ExternalConfig),
      [{unquote(app), [{unquote(key), unquote(opts)}]}])
    end
  end

  def read!(file) do
    try do
      {config, binding} = Code.eval_file(file)

      config =
      case List.keyfind(binding, {:config_agent, ExternalConfig}, 0) do
        {_, agent} -> get_config_and_stop_agent(agent)
        nil -> config
      end

      validate!(config)
      config
    rescue
      e in [LoadError] -> reraise(e, System.stacktrace)
      e -> reraise(LoadError, [file: file, error: e], System.stacktrace)
    end
  end

  def validate!(config) do
    if is_list(config) do
      Enum.all?(config, fn
        {app, value} when is_atom(app) ->
          if Keyword.keyword?(value) do
            true
          else
            raise ArgumentError,
            "Expected config for app #{inspect(app)} to return keyword list, got: #{inspect(value)}"
          end
        _ ->
          false
      end)
    else
      raise ArgumentError,
      "Expected config file to return keyword list, got: #{inspect(config)}"
    end
  end

  defp get_config_and_stop_agent(agent) do
    config = Agent.get(agent, &(&1))
    Agent.stop(agent)
    config
  end

  def agent_merge(agent, new_config) do
    Agent.update(agent, &ExternalConfig.merge(&1, new_config))
  end

  def merge(config1, config2) do
    Keyword.merge(config1, config2, fn _, app1, app2 ->
      Keyword.merge(app1, app2, &deep_merge/3)
    end)
  end

  defp deep_merge(_key, value1, value2) do
    if Keyword.keyword?(value1) and Keyword.keyword?(value2) do
      Keyword.merge(value1, value2, &deep_merge/3)
    else
      value2
    end
  end

end
