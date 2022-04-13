defmodule Solar.MixProject do
  use Mix.Project

  def project do
    [
      app: :solar,
      version: "0.2.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:hackney, "~> 1.18"},
      {:jason, "~> 1.2"},
      {:poison, "~> 5.0"},
      {:plug_cowboy, "~> 2.5"},
      {:tesla, "~> 1.4"}
    ]
  end
end
