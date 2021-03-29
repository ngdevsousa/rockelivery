defmodule Rockelivery.Factory do
  use ExMachina

  def user_params_factory do
    %{
      address: "Av.",
      age: 20,
      cep: "0000-000",
      cpf: "000.000.000-00",
      name: "foo",
      password: "P@ssw0rd",
      email: "foo@email.com"
    }
  end
end
