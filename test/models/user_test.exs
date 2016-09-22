defmodule Bookmarks.UserTest do
  use Bookmarks.ModelCase, async: true

  alias Bookmarks.User

  @valid_attrs %{
    name: "Vladmir Putin",
    email: "putin@kremlin.ru",
    password: "secret"
  }

  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "trims fields" do
    changeset = User.changeset(%User{}, Map.merge(@valid_attrs, %{
      name: " Matty Groves  ", email: "  matty42069@hotmail.com "}))
    assert changeset.changes.name == "Matty Groves"
    assert changeset.changes.email == "matty42069@hotmail.com"
  end

  test "registration_changeset with valid password hashes password" do
    attrs = Map.put(@valid_attrs, :password, "123456")
    changeset = User.registration_changeset(%User{}, attrs)
    %{password: pass, password_hash: pass_hash} = changeset.changes
    assert changeset.valid?
    assert pass_hash
    assert Comeonin.Bcrypt.checkpw(pass, pass_hash)
  end
end
