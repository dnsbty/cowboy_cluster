defmodule CowboyCluster.Web do
  @moduledoc """
  Handles any HTTP requests that come in. No matter the request, will reply with
  a simple text body that says "I am server X", where X will be replaced with
  the name of the node that was provided upon starting the application.
  """

  def init(request, state) do
    handle(request, state)
  end

  def handle(request, state) do
    request = :cowboy_req.reply(200, %{"content-type" => "text/plain"}, response_body(), request)

    {:ok, request, state}
  end

  def response_body, do: "I am server #{Node.self()}"

  def terminate(_reason, _request, _state), do: :ok
end
