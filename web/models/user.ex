defmodule Bookmarks.User do
  use Bookmarks.Web, :model

  schema "users" do
    field :name, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(name email))
    |> validate_length(:email, min: 1, max: 100)
  end
end
