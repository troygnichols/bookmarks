defmodule Bookmarks.SessionController do
  use Bookmarks.Web, :controller

  alias Bookmarks.AuthPlug, as: Auth
  alias Bookmarks.Repo

  def index(conn, _) do
    redirect conn, to: session_path(conn, :new)
  end

  def new(conn, _) do
    render conn, "new.html"
  end

  def create(conn, %{"session"=>%{"email"=>email, "password"=>pass}}) do
    case Auth.login_by_email_and_pass(conn, email, pass, repo: Repo) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: page_path(conn, :index))
      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Invalid email/password combo")
        |> render("new.html")
    end
  end
end
