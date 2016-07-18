defmodule Example.Config do
  use GenServer

  @home "/etc/example"

  def start_link() do
    start_link([])
  end
  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  ### Public API
  @doc """
  Return current config
  """
  def config do
    GenServer.call(__MODULE__, :currnet_config)
  end
  @doc """
    Fetch a value for key section in a config file
  """
  def lookup(key) do
    GenServer.call(__MODULE__, {:lookup, key})
  end

  @doc """
    Re-read config file
  """
  def sighup do
    GenServer.call(__MODULE__, :reread_config)
  end

  def init(opts) do
    {:ok, load_config}
  end
 
  def handle_call(:currnet_config, _from, state) do
    {:reply, state, state}
  end
  def handle_call({:lookup, key}, _from, state) do
    {:reply, Keyword.get(state, key), state}
  end
  def handle_call(:reread_config, _from, state) do
    config = load_config
    {:reply, config, config}
  end
  def handle_call(_message, _from, state) do
    {:reply, state}
  end

  defp load_config do
    config_path = Path.join([@home, "system.config"])
    Keyword.fetch!(ExternalConfig.read!(config_path), :system)
  end
end

