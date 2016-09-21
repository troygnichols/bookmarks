defmodule Bookmarks.UserController do
  use Bookmarks.Web, :controller

  alias Bookmarks.User
  alias Bookmarks.Repo

  def index(conn, _params) do
    users = Repo.all(User)
    render conn, "index.html", users: users
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"user"=>user_params}) do
    changeset = User.registration_changeset(%User{}, user_params)
    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "#{user.name} created")
        |> redirect(to: user_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end

  end

  def show(conn, %{"id"=>id}) do
    user = Repo.get!(User, id)
    render conn, "show.html", user: user
  end

  def edit(conn, %{"id"=>id}) do
    user = Repo.get!(User, id)
    changeset = User.changeset(%User{})
    render conn, "edit.html", changeset: changeset, user: user
  end

  def update(conn, %{"id"=>id, "user"=>user_params}) do
    changeset = User.changeset(%User{id: String.to_integer(id)}, user_params)
    {:ok, user} = Repo.update(changeset)

    conn
    |> put_flash(:info, "#{user.name} updated")
    |> redirect(to: user_path(conn, :show, id))
  end

  def delete(conn, %{"id"=>id}) do
    Repo.delete!(%User{id: String.to_integer(id)})

    conn
    |> put_flash(:info, "Deleted user #{id}")
    |> redirect(to: user_path(conn, :index))
  end
end
