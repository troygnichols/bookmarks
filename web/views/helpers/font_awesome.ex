defmodule Bookmarks.FontAwesomeHelpers do

  use Phoenix.HTML

  def font_awesome(icon_name) do
    raw ~s(<i class="fa fa-#{icon_name}"></i>)
  end

  def font_awesome_link(text, icon_name, options) do
    placement = Keyword.get(options, :icon_placement, "before")
    link(html_options(options)) do
      {:safe, icon} = font_awesome(icon_name)
      {:safe, icon_placement(text, icon, placement)}
    end
  end

  def font_awesome_link(icon_name, options) do
    font_awesome_link(nil, icon_name, options)
  end

  def font_awesome_submit(text, icon_name, options \\ []) do
    defaults = [type: :submit, to: "javascript:void(0)"]
    {:safe, icon} = font_awesome(icon_name)
    placement = Keyword.get(options, :icon_placement, "before")
    button({:safe, icon_placement(text, icon, placement)},
     Keyword.merge(defaults, html_options(options)))
  end

  defp icon_placement(text, icon, placement) do
    case placement do
      "before" ->
        icon <> " #{text}"
      "after" ->
        "#{text} " <> icon
      _ ->
        raise "Unkonwn icon placement: #{placement}"
    end
  end

  defp html_options(options) do
    Keyword.drop(options, [:icon_placement])
  end
end
