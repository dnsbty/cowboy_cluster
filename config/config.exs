use Mix.Config

config :cowboy_cluster,
  web_port: 3000,
  hosts: [:"a@127.0.0.1", :"b@127.0.0.1", :"c@127.0.0.1"]
