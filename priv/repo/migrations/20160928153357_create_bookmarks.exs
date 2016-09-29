defmodule Bookmarks.Repo.Migrations.CreateBookmarks do
  use Ecto.Migration

  def change do
    create table(:bookmarks) do
      add :user_id, references(:users), null: false
      add :name, :string, size: 200
      add :url, :string, size: 3000
      add :notes, :text
      timestamps()
    end
  end
end
