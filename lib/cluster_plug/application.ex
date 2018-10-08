defmodule CowboyCluster.Application do
  use Application

  def start(_type, _args) do
    hosts = Application.get_env(:cowboy_cluster, :hosts)

    topologies = [
      local: [
        strategy: Cluster.Strategy.Epmd,
        config: [hosts: hosts]
      ]
    ]

    children = [
      {Cluster.Supervisor, [topologies, [name: CowboyCluster.ClusterSupervisor]]},
      {Squabble, [subscriptions: [CowboyCluster.Leader], size: length(hosts)]}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: CowboyCluster.Supervisor)
  end
end
