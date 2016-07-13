defmodule ExternalConfigTest do
  use ExUnit.Case

  test "can read config file" do
    config_path = Path.join([System.cwd, "test", "support", "sample.config"])
    config = ExternalConfig.read!(config_path)
    assert Keyword.has_key?(config, :system)
    assert is_list(config)
  end
  test "reading bad config file throws error" do
    config_path = Path.join([System.cwd, "test", "support", "bad_sample.config"])
    assert_raise(ExternalConfig.LoadError, fn ->
      ExternalConfig.read!(config_path)
    end)
  end
  test "bad config raises ArgumentError for validation" do
    assert_raise(ArgumentError, fn ->
      ExternalConfig.validate!(%{})
    end)
  end
end
