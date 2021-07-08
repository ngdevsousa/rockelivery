defmodule Rockelivery.Users.CreateTest do
  use Rockelivery.DataCase, async: true

  import Rockelivery.Factory
  import Mox

  alias Rockelivery.{Error, User}
  alias Rockelivery.Users.Create
  alias Rockelivery.ViaCep.ClientMock

  describe "call/1" do
    test "it should return a new user, when all params are valid" do
      expect(ClientMock, :get_cep_info, fn _cep ->
        {:ok, build(:cep_info)}
      end)

      result =
        build(:user_params)
        |> Create.call()

      assert {:ok, %User{id: _id, age: 20, email: "foo@email.com"}} = result
    end

    test "it should return an error, when invalid params are provided" do
      result =
        build(:user_params, %{"password" => "foo"})
        |> Create.call()

      assert {:error, %Error{status: :bad_request, result: changeset}} = result
      expected_result = %{password: ["should be at least 8 character(s)"]}

      assert errors_on(changeset) == expected_result
    end
  end
end
