defmodule AlumniBook.Mixfile do
  use Mix.Project

  def project do
    [
      app: :alumni_book,
      version: "0.0.1",
      elixir: "~> 1.3",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix] ++ Mix.compilers(),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {AlumniBook, []},
      applications: [
        :phoenix,
        :phoenix_html,
        :cowboy,
        :logger,
        :phoenix_ecto,
        :phauxth,
        :postgrex,
        :oauth,
        :ueberauth_facebook,
        :ueberauth_google,
        :ueberauth_github,
        :ueberauth_identity,
        :ueberauth_linkedin,
        :ueberauth_slack,
        :ueberauth_twitter,
        :httpoison,
        :cors_plug
      ]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:cors_plug, "~> 1.5"},
      {:cowboy, "~> 1.0"},
      {:dogma, ">= 0.0.0", only: [:dev, :test]},
      {:ecto_enum, "~> 1.1"},
      {:httpoison, "~> 1.2.0", override: true},
      {:ueberauth, "~> 0.4"},
      {:oauth2, "~> 0.8", override: true},
      {:oauth, github: "tim/erlang-oauth"},
      {:phauxth, "~> 1.2"},
      {:phoenix, "~> 1.3.2"},
      {:phoenix_ecto, "~> 3.2"},
      {:phoenix_html, "~> 2.9"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:poison, "~> 3.0", override: true},
      {:postgrex, "~> 0.13"},
      {:ueberauth_facebook, "~> 0.5"},
      {:ueberauth_google, "~> 0.5"},
      {:ueberauth_github, "~> 0.4"},
      {:ueberauth_identity, "~> 0.2"},
      {:ueberauth_linkedin, "~> 0.3"},
      {:ueberauth_slack, "~> 0.4"},
      {:ueberauth_twitter, "~> 0.2"}
    ]
  end

  # Aliases are shortcut or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
