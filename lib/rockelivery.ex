defmodule Rockelivery do
  alias Rockelivery.Items.Create, as: CreateItem

  alias Rockelivery.Orders.Create, as: CreateOrder

  alias Rockelivery.Users.Create, as: UserCreate
  alias Rockelivery.Users.Delete, as: DeleteUserByID
  alias Rockelivery.Users.Get, as: GetUserByID
  alias Rockelivery.Users.Update, as: UpdateUser

  defdelegate create_item(params), to: CreateItem, as: :call

  defdelegate create_order(params), to: CreateOrder, as: :call

  defdelegate create_user(params), to: UserCreate, as: :call
  defdelegate delete_user_by_id(id), to: DeleteUserByID, as: :call
  defdelegate get_user_by_id(id), to: GetUserByID, as: :by_id
  defdelegate update_user(params), to: UpdateUser, as: :call
end
