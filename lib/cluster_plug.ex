defmodule CowboyCluster do
  @moduledoc """
  CowboyCluster allows you to start several nodes that will form a cluster and
  elect a leader. Once that leader is elected, it will start a web server
  listening on port 3000. If at any time that leader goes down, one of the other
  nodes in the cluster will take its place and start a new web server.

  To get started, modify `config/config.exs` to reflect the port you want the
  web server to listen on and the names of the nodes that you intend to stand
  up. For example, the following code will tell CowboyCluster to expect three
  nodes:
  ```
  config :cowboy_cluster,
    web_port: 3000,
    hosts: [:"a@127.0.0.1", :"b@127.0.0.1", :"c@127.0.0.1"]
  ```

  Then, start those nodes in separate Terminal panes:
  ```
  iex --name a@127.0.0.1 -S mix
  iex --name b@127.0.0.1 -S mix
  iex --name c@127.0.0.1 -S mix
  ```

  Now you can navigate your browser to http://localhost:3000 (change the port to
  match your specified configuration). You should see `I am server a@127.0.0.1`
  (or one of the other host names).

  If you stop that node, you should then be able to refresh your browser and see
  a different host name there.
  """
end
