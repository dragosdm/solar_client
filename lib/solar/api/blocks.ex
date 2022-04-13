defmodule Solar.API.Blocks do
  @moduledoc false

  alias Solar.Client.Request
  alias Solar.Client

  def first(config \\ %{}) do
    request_op("api/blocks/first", [], config, &map_block/1)
  end

  def last(config \\ %{}) do
    request_op("api/blocks/last", [], config, &map_block/1)
  end

  def all(params, config \\ %{}) do
    request_op("api/blocks", params, config, &map_blocks/1)
  end

  def get_by_id(id, config \\ %{}) do
    request_op("api/blocks/#{id}", [], config, &map_block/1)
  end

  def get_transactions(id, params, config \\ %{}) do
    request_op("api/blocks/#{id}/transactions", params, config, &map_transactions/1)
  end

  defp request_op(endpoint, params, config, mapper) do
    c = config[:client] || Solar

    Request
    |> struct(method: :get, endpoint: endpoint, query: params)
    |> Request.add_metadata(config)
    |> c.send_request(Client.new(config))
    |> c.handle_response(mapper)
  end

  defp map_block(body) do
    Poison.Decode.transform(
      body["data"],
      %{
        as: %Solar.Block{}
      }
    )
  end

  defp map_blocks(body) do
    Poison.Decode.transform(
      body,
      %{
        as: %Solar.Blocks{data: [%Solar.Block{}], meta: %Solar.Blocks.Meta{}}
      }
    )
  end

  defp map_transactions(body) do
    Poison.Decode.transform(
      body,
      %{
        as: %Solar.Blocks.Transactions{
          data: [%Solar.Blocks.Transaction{}],
          meta: %Solar.Blocks.Meta{}
        }
      }
    )
  end
end
