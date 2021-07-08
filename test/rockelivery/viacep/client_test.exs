defmodule Rockelivery.ViaCep.ClientTest do
  use ExUnit.Case, async: true

  import Rockelivery.Factory

  alias Rockelivery.Error
  alias Rockelivery.ViaCep.Client

  describe "get_cep_info/1" do
    setup do
      bypass = Bypass.open()

      {:ok, bypass: bypass}
    end

    test "it should return the cep info if a valid cep is provided", %{bypass: bypass} do
      cep = "01001000"
      url = build_url(bypass.port)
      body = ~s({
        "cep": "01001-000",
        "logradouro": "Praça da Sé",
        "complemento": "lado ímpar",
        "bairro": "Sé",
        "localidade": "São Paulo",
        "uf": "SP",
        "ibge": "3550308",
        "gia": "1004",
        "ddd": "11",
        "siafi": "7107"
      })

      Bypass.expect(bypass, "GET", "#{cep}/json/", fn conn ->
        conn
        |> Plug.Conn.put_resp_header("content-type", "application/json")
        |> Plug.Conn.resp(200, body)
      end)

      res = Client.get_cep_info(url, cep)

      expected_res = {:ok, build(:cep_info)}

      assert res == expected_res
    end

    test "it should return an error if an invalid cep is provided", %{bypass: bypass} do
      cep = "invalid_cep"
      url = build_url(bypass.port)

      Bypass.expect(bypass, "GET", "#{cep}/json/", fn conn ->
        conn
        |> Plug.Conn.put_resp_header("content-type", "application/json")
        |> Plug.Conn.resp(400, "")
      end)

      res = Client.get_cep_info(url, cep)

      expected_res = {:error, %Error{result: "Invalid CEP", status: :bad_request}}

      assert res == expected_res
    end

    test "it should return an error if the cep isn't found", %{bypass: bypass} do
      cep = "00000000"
      url = build_url(bypass.port)
      body = ~s({"error": true})

      Bypass.expect(bypass, "GET", "#{cep}/json/", fn conn ->
        conn
        |> Plug.Conn.put_resp_header("content-type", "application/json")
        |> Plug.Conn.resp(200, body)
      end)

      res = Client.get_cep_info(url, cep)

      expected_res = {:error, %Error{result: "CEP NOT FOUND", status: :not_found}}

      assert res == expected_res
    end

    test "it should return an error if the server is down", %{bypass: bypass} do
      cep = "00000000"
      url = build_url(bypass.port)

      Bypass.down(bypass)

      res = Client.get_cep_info(url, cep)

      expected_res = {:error, %Error{result: :econnrefused, status: :bad_request}}

      assert res == expected_res
    end

    defp build_url(port), do: "http://localhost:#{port}/"
  end
end
