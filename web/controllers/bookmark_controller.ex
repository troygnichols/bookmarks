defmodule Bookmarks.BookmarkController do
  use Bookmarks.Web, :controller

  plug :authenticate_user

  alias Bookmarks.Bookmark

  alias Bookmarks.AuthPlug, as: Auth

  def index(conn, _params) do
    bookmarks = Repo.all(
      from b in Bookmark, where: b.user_id == ^conn.assigns.current_user.id)

    render(conn, "index.html", bookmarks: bookmarks, user: conn.assigns.current_user)
  end

  def new(conn, _params) do
    changeset = Bookmark.changeset(%Bookmark{})
    render(conn, "new.html", changeset: changeset, user: conn.assigns.current_user)
  end

  def create(conn, %{"bookmark"=>bookmark_params}) do
    changeset = Bookmark.changeset(%Bookmark{user: conn.assigns.current_user}, bookmark_params)

    case Repo.insert(changeset) do
      {:ok, bookmark} ->
        conn
        |> redirect(to: user_bookmark_path(conn, :show, bookmark.user_id, bookmark.id))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id"=>id}) do
    bookmark = Repo.get!(Bookmark, id)
    render(conn, "show.html", bookmark: bookmark)
  end

  def edit(conn, %{"id"=>id}) do
    bookmark = Repo.get!(Bookmark, id) |> Repo.preload([:user])
    changeset = Bookmark.changeset(bookmark)
    render(conn, "edit.html", changeset: changeset, bookmark: bookmark)
  end

  def update(conn, %{"id"=>id, "bookmark"=>bookmark_params}) do
    bookmark = Repo.get!(Bookmark, id) |> Repo.preload([:user])
    changeset = Bookmark.changeset(bookmark, bookmark_params)
    case Repo.update(changeset) do
      {:ok, bookmark} ->
        conn
        |> redirect(to: user_bookmark_path(conn, :show, bookmark.user_id, id))
      {:error, changeset} ->
        render(conn, "edit.html", changeset: changeset, bookmark: bookmark)
    end
  end

  def delete(conn, %{"id"=>id}) do
    Repo.delete!(%Bookmark{id: String.to_integer(id)})
    conn
    |> put_flash(:info, "Note deleted")
    |> redirect(to: user_bookmark_path(conn, :index, conn.assigns.current_user))
  end
end
