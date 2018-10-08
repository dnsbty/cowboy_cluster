# CowboyCluster

CowboyCluster allows you to start several nodes that will form a cluster and
elect a leader. Once that leader is elected, it will start a web server
listening on port 3000. If at any time that leader goes down, one of the other
nodes in the cluster will take its place and start a new web server.

## Installation

Make sure you have Elixir 1.7 and OTP 21 installed on your machine. Then get the
project's dependencies with
```
mix deps.get
```

Finally, modify `config/config.exs` to reflect the port you want the
web server to listen on and the names of the nodes that you intend to stand
up. For example, the following code will tell CowboyCluster to listen on port
3000 and to expect three nodes:
```
config :cowboy_cluster,
  web_port: 3000,
  hosts: [:"a@127.0.0.1", :"b@127.0.0.1", :"c@127.0.0.1"]
```

## To test out the project

Start the nodes you specified in the configuration in separate Terminal panes:
```
iex --name a@127.0.0.1 -S mix
iex --name b@127.0.0.1 -S mix
iex --name c@127.0.0.1 -S mix
```

*NOTE: The nodes must be started rather quickly. Squabble requires that all
nodes be present before beginning leader election. Currently leader election
begins once the clustering stuff is set up. This could be fixed by waiting until
the Node list contains all expected nodes before starting leader election.*

Now you can navigate your browser to
[http://localhost:3000](http://localhost:3000) (change the port to match your
specified configuration). You should see `I am server a@127.0.0.1` (or one of
the other host names).

If you stop that node, you should then be able to refresh your browser and see
a different host name there.

## Gotchas

One tradeoff this project makes is that if more than one node is specified in
the configuration, and one of the nodes goes down, the web server will be
stopped. Because of a partition with only one node on each side, we are unsure
which should be the leader, so we stop the server on both sides until a
connection is reestablished.

## Under the hood

This example relies on [libcluster](https://github.com/bitwalker/libcluster) for
the automatic cluster setup, and on
[Squabble](https://github.com/oestrich/squabble), an implementation of the [Raft
Consensus Algorithm](https://raft.github.io/), for leader election. The web
server is [Cowboy](https://github.com/ninenines/cowboy).
