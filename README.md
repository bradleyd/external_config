# ExternalConfig

ExternalConfig can be used for when you need to have a configuration file outside of your application but still want to use `Mix.Config` style.

This becomes very useful when your application is a release.


* see `test/support/sample.config` for example.

* see usage example in `examples`


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `external_config` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:external_config, "~> 0.1.0"}]
    end
    ```

  2. Ensure `external_config` is started before your application:

    ```elixir
    def application do
      [applications: [:external_config]]
    end
    ```

