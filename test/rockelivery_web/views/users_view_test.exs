defmodule RockeliveryWeb.UsersViewTest do
  use RockeliveryWeb.ConnCase, async: true

  import Phoenix.View
  import Rockelivery.Factory

  alias RockeliveryWeb.UsersView

  test "renders created.json" do
    user = build(:user)

    result = render(UsersView, "created.json", access_token: "token", user: user)

    expected_result = %{
      access_token: "token",
      message: "User created",
      user: %Rockelivery.User{
        address: "Av.",
        age: 20,
        cep: "0000-000",
        cpf: "000.000.000-00",
        email: "foo@email.com",
        id: "1a29846e-513f-4d22-8152-d5e0fbf373f8",
        inserted_at: nil,
        name: "foo",
        password: "P@ssw0rd",
        password_hash: nil,
        updated_at: nil
      }
    }

    assert result == expected_result
  end
end
