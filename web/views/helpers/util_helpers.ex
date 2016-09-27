defmodule Bookmarks.UtilHelpers do
  use Phoenix.HTML

  def or_div do
    raw ~s(<div class="or-container"><hr class="or-hr"></hr><div class="or">or</div></div>)
  end

  def username(user) do
    Bookmarks.User.username(user)
  end

  def external_auth_links(conn) do
    Phoenix.View.render(Bookmarks.ExternalAuthView,
      "external_auth_links.html", conn: conn)
  end
end
