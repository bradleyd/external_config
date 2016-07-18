defmodule ExternalConfig.Mixfile do
  use Mix.Project

  @version "0.1.0"

  def project do
    [app: :external_config,
      version: "0.1.0",
      elixir: "~> 1.0",
      build_embedded: false,
      start_permanent: false,
      source_url: "https://github.com/bradleyd/external_config",
      description: description(),
      package: package(),
      deps: deps()]
  end

  def application do
    [applications: [:logger]]
  end

  defp description do
    """
    ExternalConfig provides a way to use an external mix style configuration (to your application) file in a release or application. 
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md", "LICENSE"],
      maintainers: ["Bradley Smith"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/bradleyd/external_config"}
    ]
  end

  defp deps do
    []
  end
end
