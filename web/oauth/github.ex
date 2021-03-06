defmodule GitHub do
  use OAuth2.Strategy

  alias OAuth2.Strategy.AuthCode

  defp config do
    [
      strategy: __MODULE__,
      site: "api.github.com",
      authorize_url: "https://github.com/login/oauth/authorize",
      token_url: "https://github.com/login/oauth/access_token"
    ]
  end

  # Public API

  def client do
    Application.get_env(:bookmarks, __MODULE__)
    |> Keyword.merge(config())
    |> OAuth2.Client.new()
  end

  def authorize_url!(params \\ []) do
    OAuth2.Client.authorize_url!(client(), params)
  end

  def get_token!(params \\ [], _headers \\ []) do
    client_secret = client().client_secret
    p = Keyword.merge(params, client_secret: client_secret)
    OAuth2.Client.get_token!(client(), p)
  end

  # Strategy callbacks

  def authorize_url(client, params) do
    AuthCode.authorize_url(client, params)
  end

  def get_token(client, params, headers) do
    client
    |> put_header("Accept", "application/json")
    |> AuthCode.get_token(params, headers)
  end
end
