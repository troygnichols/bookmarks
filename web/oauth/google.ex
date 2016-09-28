defmodule Google do
  use OAuth2.Strategy

  alias OAuth2.Strategy.AuthCode

  defp config do
    [
      strategy:      __MODULE__,
      site:          "https://accounts.google.com",
      authorize_url: "/o/oauth2/auth",
      token_url:     "/o/oauth2/token"
    ]
  end

  # Public API

  def client do
    Keyword.merge(Application.get_env(:bookmarks, __MODULE__), config())
    |> OAuth2.Client.new()
  end

  def authorize_url!(params \\ []) do
    OAuth2.Client.authorize_url!(client(), params)
  end

  def get_token!(params \\ [], _headers \\ []) do
    OAuth2.Client.get_token!(client(),
      Keyword.merge(params, client_secret: client().client_secret))
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
