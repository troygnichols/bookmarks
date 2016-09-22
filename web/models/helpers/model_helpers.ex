defmodule Bookmarks.ModelHelpers do

  alias Ecto.Changeset

  def trim_fields(changeset, fields) when is_list(fields) do
    Enum.reduce(fields, changeset, fn (field, changeset) ->
      %{changes: changes, errors: _errors} = changeset
      case Map.get(changes, field) do
        nil ->
          changeset
        value ->
          Changeset.put_change(changeset, field, String.trim(value))
      end
    end)
  end
end
