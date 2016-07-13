defmodule ExternalConfig.Mixfile do
  use Mix.Project

  def project do
    [app: :external_config,
      version: "0.1.0",
      elixir: "~> 1.2",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps()]
  end

  def application do
    [applications: [:logger]]
  end

  defp description do
    """
    ExternalConfig provides a way to use an external configuration file in a release or standalone.
    This is an alternative to using relx replace vars or crystalizing ENV vars during `mix release` 
    """
  end

  defp package do
    [
      name: :external_config,
      files: ["lib", "priv", "mix.exs", "README*", "readme*", "LICENSE*", "license*"],
      maintainers: ["Bradley Smith"],
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => "https://github.com/bradleyd/external_config",
	"Docs" => ""}
    ]
  end
  defp deps do
    []
  end
end
