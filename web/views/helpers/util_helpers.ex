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

  def shorten(text, len \\ 20, suffix \\ "…") do
    if String.length(text) < len do
      text
    else
      String.slice(text, 0..len-1) <> suffix
    end
  end

  def present?(value) do
    if value do
      String.length(value) > 0
    else
      false
    end
  end
end
