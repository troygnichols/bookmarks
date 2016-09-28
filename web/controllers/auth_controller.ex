defmodule Bookmarks.AuthController do
  use Bookmarks.Web, :controller

  import Ecto.Query

  alias Bookmarks.AuthPlug, as: Auth
  alias Bookmarks.Repo

  alias Bookmarks.OauthAuthorization
  alias Bookmarks.User

  def index(conn, %{"provider"=>provider}) do
    redirect conn, external: authorize_url!(provider)
  end

  def callback(conn, %{"provider"=>provider, "code"=>code}) do
    client = get_token!(provider, code)
    user = get_user!(provider, client)

    conn
    |> Auth.login(user)
    |> put_session(:access_token, client.token.access_token)
    |> redirect(to: page_path(conn, :index))
  end

  defp authorize_url!("google") do
    Google.authorize_url!(scope: "https://www.googleapis.com/auth/userinfo.profile")
  end

  defp authorize_url!("github") do
    GitHub.authorize_url!()
  end

  defp authorize_url!("facebook") do
    Facebook.authorize_url!()
  end

  defp authorize_url!(provider) do
    raise "Unknown provider: #{provider}"
  end

  defp get_token!("google", code) do
    Google.get_token!(code: code)
  end

  defp get_token!("github", code) do
    GitHub.get_token!(code: code)
  end

  defp get_token!("facebook", code) do
    Facebook.get_token!(code: code)
  end

  defp get_user!(provider = "google", client) do
    url = "https://www.googleapis.com/plus/v1/people/me/openIdConnect"
    %{body: user} = OAuth2.Client.get!(client, url)
    find_or_create_user(provider, user["sub"])
  end

  defp get_user!(provider = "github", client) do
    url = "https://api.github.com/user"
    %{body: user} = OAuth2.Client.get!(client, url)
    find_or_create_user(provider, user["id"])
  end

  defp get_user!(provider = "facebook", client) do
    %{body: user} = OAuth2.Client.get!(client, "/me", fields: "id,name")
    IO.puts "user: #{inspect user}"
    find_or_create_user(provider, user["id"])
  end

  defp find_or_create_user(provider, uid) do
    query = from o in OauthAuthorization, join: u in assoc(o, :user),
      where: o.provider == ^provider, preload: [user: u]

    if auth = Repo.one(query) do
      auth.user
    else
      {:ok, user} = Repo.transaction(fn ->
        user = Repo.insert!(%User{})
        Repo.insert!(%OauthAuthorization{provider: provider, uid: "#{uid}", user_id: user.id})
        user
      end)
      user
    end
  end
end
