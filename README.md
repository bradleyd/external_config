# ExternalConfig

ExternalConfig can be used when you need to have a configuration file outside of your application/release, but still want to use a `Mix.Config` style.

I use this pattern primarily in releases.  I do not have to worry about dynamic ENV vars being set for different environments during compile time.  I let my deployment tool create the config file and place it accordingly.  

The concept is this:  Create a gen_server (see example application) that reads the config in and saves it as state.  This child should be started before the module that will need to call it. Then in another process or module make `call` to `Config` gen_server to get config.


* see `test/support/sample.config` for example.

* see usage example in `examples`


* TODO better docs


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

