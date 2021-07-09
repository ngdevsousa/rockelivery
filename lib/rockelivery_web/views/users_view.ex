defmodule RockeliveryWeb.UsersView do
  use RockeliveryWeb, :view
  alias Rockelivery.User

  def render("created.json", %{access_token: token, user: %User{} = user}) do
    %{
      access_token: token,
      message: "User created",
      user: user
    }
  end

  def render("sign_in.json", %{access_token: token}), do: %{access_token: token}

  def render("show.json", %{user: %User{} = user}), do: %{user: user}
end
