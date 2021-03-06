defmodule Rockelivery.Factory do
  use ExMachina.Ecto, repo: Rockelivery.Repo

  alias Rockelivery.User

  def user_params_factory do
    %{
      "address" => "Av.",
      "age" => 20,
      "cep" => "0000-000",
      "cpf" => "000.000.000-00",
      "name" => "foo",
      "password" => "P@ssw0rd",
      "email" => "foo@email.com"
    }
  end

  def user_request_factory do
    %{
      "address" => "Av.",
      "age" => 20,
      "cep" => "0000-000",
      "cpf" => "000.000.000-00",
      "name" => "foo",
      "password" => "P@ssw0rd",
      "email" => "foo@email.com"
    }
  end

  def user_factory do
    %User{
      address: "Av.",
      age: 20,
      cep: "0000-000",
      cpf: "000.000.000-00",
      name: "foo",
      password: "P@ssw0rd",
      email: "foo@email.com",
      id: "1a29846e-513f-4d22-8152-d5e0fbf373f8"
    }
  end

  def cep_info_factory do
    %{
      "bairro" => "Sé",
      "cep" => "01001-000",
      "complemento" => "lado ímpar",
      "ddd" => "11",
      "gia" => "1004",
      "ibge" => "3550308",
      "localidade" => "São Paulo",
      "logradouro" => "Praça da Sé",
      "siafi" => "7107",
      "uf" => "SP"
    }
  end
end
