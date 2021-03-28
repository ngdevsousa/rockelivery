defmodule RockeliveryWeb.UsersView do
  use RockeliveryWeb, :view
  alias Rockelivery.User

  def render("created.json", %{user: %User{} = user}) do
    %{
      message: "User created",
      user: user
    }
  end
end
