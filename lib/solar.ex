defmodule Solar do
  @moduledoc """
  An HTTP Client for Solar (SXP) Blockchain.
  [Solar API Docs](https://docs.solar.org/api/)
  """

  alias Solar.Client.Request

  defmodule MissingRootUriError do
    defexception message: """
                 The `root_uri` is required for calls to Solar.
                 Please configure root_uri in your config.exs file.

                 config :solar, root_uri: "scheme://host:port"
                 """
  end

  @doc false
  def send_request(request, client) do
    request |> Request.to_options() |> then(&Tesla.request(client, &1))
  end

  @doc false
  def handle_response({:ok, %Tesla.Env{status: status} = env}, mapper) when status in 200..299 do
    {:ok, mapper.(env.body)}
  end

  def handle_response({:ok, %Tesla.Env{} = env}, _mapper) do
    error = Poison.Decode.transform(env.body, %{as: %Solar.Error{}})
    {:error, %{error | status_code: env.status}}
  end

  def handle_response({:error, _reason} = error, _mapper) do
    error
  end
end
