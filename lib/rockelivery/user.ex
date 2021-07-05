defmodule Rockelivery.User do
  use Ecto.Schema

  import Ecto.Changeset

  alias Ecto.Changeset
  alias Rockelivery.Order

  @primary_key {:id, :binary_id, autogenerate: true}
  @required_params [:address, :age, :cep, :cpf, :email, :name, :password]
  @required_update_params @required_params -- [:password]
  @derive {Jason.Encoder, only: [:id, :age, :cpf, :address, :email, :name]}

  schema "users" do
    field :address, :string
    field :age, :integer
    field :cep, :string
    field :cpf, :string
    field :email, :string
    field :name, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    has_many :orders, Order

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
    |> validate_length(:password, min: 8)
    |> validate_length(:cep, min: 8)
    |> validate_length(:cpf, min: 11)
    |> validate_number(:age, greater_than_or_equal_to: 18)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint([:cpf])
    |> unique_constraint([:email])
    |> apply_password_hash()
  end

  defp apply_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Pbkdf2.add_hash(password))
  end

  defp apply_password_hash(changeset), do: changeset
end
