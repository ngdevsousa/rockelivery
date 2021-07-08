defmodule Rockelivery.ViaCep.Client do
  use Tesla

  alias Rockelivery.Error
  alias Rockelivery.ViaCep.Behaviour
  alias Tesla.Env

  @behaviour Behaviour

  @default_url "https://viacep.com.br/ws/"
  plug Tesla.Middleware.JSON

  def get_cep_info(url \\ @default_url, cep) do
    "#{url}#{cep}/json/"
    |> get()
    |> handle_response()
  end

  defp handle_response({:ok, %Env{status: 200, body: %{"error" => true}}}) do
    {:error, Error.build(:not_found, "CEP NOT FOUND")}
  end

  defp handle_response({:ok, %Env{status: 200, body: body}}), do: {:ok, body}

  defp handle_response({:ok, %Env{status: 400, body: _body}}) do
    {:error, Error.build(:bad_request, "Invalid CEP")}
  end

  defp handle_response({:error, reason}) do
    {:error, Error.build(:bad_request, reason)}
  end
end
