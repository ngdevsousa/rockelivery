defmodule RockeliveryWeb.ItemsView do
  use RockeliveryWeb, :view
  alias Rockelivery.Item

  def render("created.json", %{item: %Item{} = item}) do
    %{
      message: "Item created",
      item: item
    }
  end

  def render("show.json", %{item: %Item{} = item}), do: %{item: item}
end
