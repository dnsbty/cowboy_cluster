defmodule CowboyCluster.MixProject do
  use Mix.Project

  def project do
    [
      app: :cowboy_cluster,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      mod: {CowboyCluster.Application, []},
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:cowboy, "~> 2.0"},
      {:libcluster, "~> 3.0"},
      {:squabble, git: "https://github.com/oestrich/squabble.git"}
    ]
  end
end
