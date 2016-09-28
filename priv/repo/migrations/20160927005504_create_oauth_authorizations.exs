defmodule Bookmarks.Repo.Migrations.CreateOauthAuthorizations do
  use Ecto.Migration

  def change do
    create table(:oauth_authorizations) do
      add :user_id, references(:users), null: false
      add :uid, :string, null: false
      add :provider, :string, null: false

      timestamps()
    end

    create unique_index(:oauth_authorizations, [:user_id, :provider])
    create unique_index(:oauth_authorizations, [:user_id, :provider, :uid])

    create index(:oauth_authorizations, [:provider, :uid])
  end
end
