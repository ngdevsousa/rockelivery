defmodule Rockelivery do
  alias Rockelivery.Users.Create, as: UserCreate
  alias Rockelivery.Users.Delete, as: DeleteUserByID
  alias Rockelivery.Users.Get, as: GetUserByID

  defdelegate create_user(params), to: UserCreate, as: :call
  defdelegate delete_user_by_id(id), to: DeleteUserByID, as: :call
  defdelegate get_user_by_id(id), to: GetUserByID, as: :by_id
end
