defmodule RockeliveryWeb.UsersControllerTest do
  use RockeliveryWeb.ConnCase, async: true

  import Rockelivery.Factory

  describe "create/2" do
    test "it should be able to create a new user when all params are valid", %{conn: conn} do
      params = build(:user_request)

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
end
