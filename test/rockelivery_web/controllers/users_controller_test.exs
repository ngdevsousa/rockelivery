defmodule RockeliveryWeb.UsersControllerTest do
  use RockeliveryWeb.ConnCase, async: true

  import Rockelivery.Factory
  import Mox

  alias Rockelivery.ViaCep.ClientMock
  alias RockeliveryWeb.Auth.Guardian

  describe "create/2" do
    test "it should be able to create a new user when all params are valid", %{conn: conn} do
      params = build(:user_request)

      expect(ClientMock, :get_cep_info, fn _cep ->
        {:ok, build(:cep_info)}
      end)

      result =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "message" => "User created",
               "user" => %{
                 "address" => "Av.",
                 "age" => 20,
                 "cpf" => "000.000.000-00",
                 "email" => "foo@email.com",
                 "id" => _id,
                 "name" => "foo"
               }
             } = result
    end

    test "it should return an error when invalid params are provided", %{conn: conn} do
      params = build(:user_request, %{"password" => "foo"})

      result =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:bad_request)

      expected_result = %{"message" => %{"password" => ["should be at least 8 character(s)"]}}

      assert expected_result == result
    end
  end

  describe "delete/2" do
    setup %{conn: conn} do
      user = insert(:user)
      {:ok, token, _claims} = Guardian.encode_and_sign(user)
      conn = put_req_header(conn, "authorization", "Bearer #{token}")

      {:ok, conn: conn, user: user}
    end

    test "it should be able to delete a user when there's a record with the given id", %{
      conn: conn
    } do
      id = "1a29846e-513f-4d22-8152-d5e0fbf373f8"

      result =
        conn
        |> delete(Routes.users_path(conn, :delete, id))
        |> response(:no_content)

      assert result == ""
    end
  end
end
