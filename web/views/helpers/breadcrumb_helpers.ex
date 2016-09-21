defmodule Bookmarks.BreadcrumbHelpers do

  use Phoenix.HTML
  alias Bookmarks.FontAwesomeHelpers, as: FA

  def breadcrumb(name, icon: icon_name) do
    content_tag :li do
      FA.font_awesome_link name, icon_name, to: "javascript:void(0)", class: "breadcrumb-final"
    end
  end

  def breadcrumb(name, target, icon: icon_name) do
    content_tag :li do
      FA.font_awesome_link name, icon_name, to: target
    end
  end

  def breadcrumbs(opts \\ [], do: contents) do
    content_tag :ul, contents, Keyword.merge(opts, id: "breadcrumb")
  end

  def breadcrumb(name, target) do
    content_tag :li do
      link name, to: target
    end
  end

  def breadcrumb(name) do
    content_tag :li do
      link name, to: "javascript:void(0)", class: "breadcrumb-final"
    end
  end
end
