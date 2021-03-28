defmodule RockeliveryWeb.HealthController do
  use RockeliveryWeb, :controller

  def index(conn, _params) do
    conn
    |> put_status(:ok)
    |> text("")
  end
end
