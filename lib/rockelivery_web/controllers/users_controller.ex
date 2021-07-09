defmodule RockeliveryWeb.UsersController do
  use RockeliveryWeb, :controller

  alias Rockelivery.User
  alias RockeliveryWeb.{Auth.Guardian, FallbackController}

  action_fallback FallbackController

  def sign_in(conn, params) do
    with {:ok, token} <- Guardian.authenticate(params) do
      conn
      |> put_status(:ok)
      |> render("sign_in.json", access_token: token)
    end
  end

  def create(conn, params) do
    with {:ok, %User{} = user} <- Rockelivery.create_user(params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:created)
      |> render("created.json", access_token: token, user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %User{}} <- Rockelivery.delete_user_by_id(id) do
      conn
      |> put_status(:no_content)
      |> text("")
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- Rockelivery.get_user_by_id(id) do
      conn
      |> put_status(:ok)
      |> render("show.json", user: user)
    end
  end

  def update(conn, params) do
    with {:ok, %User{} = user} <- Rockelivery.update_user(params) do
      conn
      |> put_status(:ok)
      |> render("show.json", user: user)
    end
  end
end
