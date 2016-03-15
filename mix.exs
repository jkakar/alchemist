defmodule Alchemist.Mixfile do
  use Mix.Project

  def project do
    [app: :alchemist,
     description: "Carefully refactor critical paths",
     package: package,
     version: version,
     name: "alchemist",
     source_url: "https://github.com/jkakar/alchemist",
     homepage_url: "https://github.com/jkakar/alchemist",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    []
  end

  defp version do
    "0.0.2"
  end

  defp package do
    [maintainers: ["Jamu Kakar"],
     licenses: ["Apache 2.0"],
     links: %{"GitHub" => "https://github.com/jkakar/alchemist",
              "Docs" => "http://hexdocs.pm/alchemist/#{version}/"}]
  end
end
