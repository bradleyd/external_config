defmodule ExternalConfigTest do
  use ExUnit.Case
  doctest ExternalConfig

  test "can read config file" do
    config_path = Path.join([System.cwd, "test", "support", "sample.config"])
    config = ExternalConfig.read!(config_path)
    assert Keyword.has_key?(config, :system)
    assert is_list(config)
  end
end
