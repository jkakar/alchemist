defmodule Scientist.Mixfile do
  use Mix.Project

  def project do
    [app: :scientist,
     description: "Carefully refactor critical paths",
     package: package,
     version: version,
     name: "scientist",
     source_url: "https://github.com/jkakar/scientist-elixir",
     homepage_url: "https://github.com/jkakar/scientist-elixir",
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
    "0.0.1"
  end

  defp package do
    [maintainers: ["Jamu Kakar"],
     licenses: ["Apache 2.0"],
     links: %{"GitHub" => "https://github.com/jkakar/scientist-elixir",
              "Docs" => "http://hexdocs.pm/scientist/#{version}/"}]
  end
end
