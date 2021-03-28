defmodule Rockelivery.Error do
  @keys [:status, :result]
  @enforce_keys @keys

  defstruct @keys

  def build(status, result) do
    %__MODULE__{
      status: status,
      result: result
    }
  end

  def user_not_found, do: build(:not_found, "User not found")
  def invalid_uuid, do: build(:bad_request, "Invalid UUID")
  def internal_server_error, do: build(:internal_server_error, "Internal Server Error")
end
