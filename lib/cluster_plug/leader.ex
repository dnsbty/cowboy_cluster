defmodule CowboyCluster.Leader do
  @behaviour Squabble.Leader
  @moduledoc """
  Handles the functions of being the leader node. Starts the web listener when
  initially selected as leader, and shuts off the listener if connections to all
  other nodes are lost.
  """

  require Logger

  @impl true
  def leader_selected(_term) do
    Logger.debug("🏆 Selected as leader... starting web server")
    port = Application.get_env(:cowboy_cluster, :web_port)

    :cowboy.start_clear(
      :http,
      [{:port, port}],
      %{env: %{dispatch: dispatch_config}}
    )
  end

  @impl true
  def node_down do
    case Node.list() do
      [] ->
        Logger.debug("😱 Lost connection to all nodes... stopping web server")
        :cowboy.stop_listener(:http)

      _ ->
        Logger.debug("😢 Lost connection to a node")
        Logger.debug("Currently connected to: #{inspect(Node.list())}")
    end
  end

  defp dispatch_config do
    :cowboy_router.compile([
      {:_,
       [
         {:_, CowboyCluster.Web, []}
       ]}
    ])
  end
end
