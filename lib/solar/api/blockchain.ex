defmodule Solar.API.Blockchain do
  @moduledoc false

  alias Solar.Client.Request
  alias Solar.Client

  def get(config \\ %{}) do
    c = config[:client] || Solar

    Request
    |> struct(method: :get, endpoint: "api/blockchain")
    |> Request.add_metadata(config)
    |> c.send_request(Client.new(config))
    |> c.handle_response(&map_blockchain(&1))
  end

  defp map_blockchain(body) do
    Poison.Decode.transform(
      body["data"],
      %{
        as: %Solar.Blockchain{}
      }
    )
  end
end
