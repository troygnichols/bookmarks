defmodule Bookmarks.FontAwesomeHelpers do

  use Phoenix.HTML

  def font_awesome(icon_name) do
    raw ~s(<i class="fa fa-#{icon_name}"></i>)
  end

  def font_awesome_link(text, icon_name, options) do
    link(options) do
      {:safe, icon} = font_awesome(icon_name)
      {:safe, icon <> " #{text}"}
    end
  end

  def font_awesome_link(icon_name, options) do
    font_awesome_link(nil, icon_name, options)
  end

  def font_awesome_submit(text, icon_name, options \\ []) do
    defaults = [type: :submit, to: "javascript:void(0)"]
    {:safe, icon} = font_awesome(icon_name)
    content = icon <> " #{text}"
    button({:safe, content}, Keyword.merge(defaults, options))
  end
end
