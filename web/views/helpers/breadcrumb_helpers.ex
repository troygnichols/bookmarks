defmodule Bookmarks.BreadcrumbHelpers do

  use Phoenix.HTML

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
