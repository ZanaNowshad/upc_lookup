defmodule Wmart.Mixfile do
  use Mix.Project

  def project do
    [
      app: :wmart,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger, :inets],
      mod: {Wmart.Application, []}
    ]
  end

  defp deps do
    []
  end
end
