defmodule Solar.Client do
  @moduledoc """
  Functions to build a Tesla client for handling HTTP requests.
  """

  defmodule Request do
    @moduledoc """
    Data structure for an HTTP request with convenience functions.
    """

    defstruct body: %{}, endpoint: nil, method: nil, opts: %{}, query: []

    def to_options(%Request{body: b, endpoint: e, method: m, opts: o, query: q}) do
      [method: m, url: e, body: b, opts: Map.to_list(o), query: q]
    end

    def add_metadata(%Request{endpoint: e, method: m, opts: o} = request, config \\ %{}) do
      metadata =
        Map.new()
        |> Map.put(:method, m)
        |> Map.put(:path, e)
        |> Map.put(:u, :native)
        |> Map.merge(config[:telemetry_metadata] || %{})

      %{request | opts: Map.put(o, :metadata, metadata)}
    end
  end

  @doc false
  def new(config \\ %{}) do
    middleware =
      [
        {Tesla.Middleware.BaseUrl, get_base_url(config)},
        {Tesla.Middleware.Headers,
         [
           {"Content-Type", "application/json"},
           {"user-agent", "Elixir-SXP-SDK"}
         ]},
        Tesla.Middleware.JSON
      ] ++ get_middleware(config)

    adapter = {get_adapter(config), get_http_options(config)}

    Tesla.client(middleware, adapter)
  end

  defp get_base_url(config) do
    case config[:root_uri] || Application.get_env(:solar, :root_uri) do
      nil ->
        raise Solar.MissingRootUriError

      root_uri ->
        root_uri
    end
  end

  defp get_middleware(config) do
    case config[:middleware] || Application.get_env(:solar, :middleware) || [] do
      middleware when is_list(middleware) ->
        middleware

      m ->
        [m]
    end
  end

  defp get_adapter(config) do
    config[:adapter] || Application.get_env(:solar, :adapter) || Tesla.Adapter.Hackney
  end

  defp get_http_options(config) do
    Keyword.merge(
      Application.get_env(:solar, :http_options, []),
      config[:http_options] || []
    )
  end
end
