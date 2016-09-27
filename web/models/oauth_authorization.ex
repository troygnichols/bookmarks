defmodule Bookmarks.OauthAuthorization do
  use Bookmarks.Web, :model

  schema "oauth_authorizations" do
    field :provider
    field :uid

    belongs_to :user, Bookmarks.User

    timestamps()
  end
end
