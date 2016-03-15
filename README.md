# Alchemist

Carefully refactor critical paths.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add alchemist to your list of dependencies in `mix.exs`:

        def deps do
          [{:alchemist, "~> 0.0.2"}]
        end

  2. Ensure alchemist is started before your application:

        def application do
          [applications: [:alchemist]]
        end
