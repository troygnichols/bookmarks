defmodule Bookmarks.User do
  use Bookmarks.Web, :model

  alias Bookmarks.ModelHelpers, as: Helpers

  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    has_many :oauth_authorizations, Bookmarks.OauthAuthorization

    timestamps
  end

  def username(model) do
    if String.length("#{model.email}") > 0 do
      model.email
    else
      "user-#{model.id}"
    end
  end

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, ~w(email))
    |> Helpers.trim_fields([:email])
    |> validate_length(:email, max: 100)
    |> validate_required([:email])
  end

  def registration_changeset(model, params \\ %{}) do
    model
    |> changeset(params)
    |> cast(params, ~w(password), [])
    |> validate_length(:password, min: 6, max: 100)
    |> put_pass_hash()
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
        changeset
    end
  end
end
