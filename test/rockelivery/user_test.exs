defmodule Rockelivery.UserTest do
  use Rockelivery.DataCase, async: true

  import Rockelivery.Factory

  alias Ecto.Changeset
  alias Rockelivery.User

  describe "changeset/2" do
    test "it should return a valid changeset, when all params are valid" do
      params = build(:user_params)

      result = User.changeset(params)

      assert %Changeset{changes: %{name: "foo"}, valid?: true} = result
    end

    test "it should return an invalid changeset, when one of the params is invalid" do
      params =
        build(:user_params, %{
          "age" => 1,
          "cpf" => "000",
          "email" => "foo",
          "password" => "bar"
        })

      result = User.changeset(params)

      expected_result = %{
        age: ["must be greater than or equal to 18"],
        cpf: ["should be at least 11 character(s)"],
        email: ["has invalid format"],
        password: ["should be at least 8 character(s)"]
      }

      assert errors_on(result) == expected_result
    end
  end

  describe "update_changeset/2" do
    test "it should return a valid changeset, when updated params are valid" do
      params = build(:user_params)

      update_params = %{age: 30, name: "bar"}

      result =
        params
        |> User.changeset()
        |> User.update_changeset(update_params)

      assert %Changeset{changes: %{age: 30, name: "bar"}} = result
    end
  end
end
