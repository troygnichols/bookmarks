defmodule Bookmarks.Bookmark do
  use Bookmarks.Web, :model

  alias Bookmarks.ModelHelpers, as: Helpers

  schema "bookmarks" do
    field :name
    field :url
    field :notes
    belongs_to :user, Bookmarks.User
    timestamps()
  end

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, ~w(name url notes))
    |> cast_assoc(:user)
    |> Helpers.trim_fields(~w(name url notes)a)
    |> validate_required(~w(name url)a)
    |> validate_length(:name, min: 1, max: 200)
    |> validate_length(:url, min: 1, max: 3_000)
    |> validate_length(:notes, max: 10_000)
  end
end
