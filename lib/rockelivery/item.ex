defmodule Rockelivery.Item do
  use Ecto.Schema

  import Ecto.Changeset

  alias Rockelivery.Order

  @primary_key {:id, :binary_id, autogenerate: true}
  @items_categories [:food, :drink, :desert]
  @required_params [:category, :description, :price, :photo]
  @required_update_params @required_params
  @derive {Jason.Encoder, only: @required_params ++ [ :id ]}

  schema "items" do
    field :category, Ecto.Enum, values: @items_categories
    field :description, :string
    field :price, :decimal
    field :photo, :string

    many_to_many :orders, Order, join_through: "orders_items"

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    changeset(struct, @required_params, params)
  end

  def update_changeset(struct, params) do
    changeset(struct, @required_update_params, params)
  end

  defp changeset(struct, required_fields, params) do
    struct
    |> cast(params, required_fields)
    |> validate_required(required_fields)
    |> validate_number(:price, greater_than: 0)
  end
end
