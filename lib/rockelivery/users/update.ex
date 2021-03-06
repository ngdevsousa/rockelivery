defmodule Rockelivery.Users.Update do
  alias Rockelivery.{Error, Repo, User}

  def call(%{"id" => id} = params) do
    case Repo.get(User, id) do
      nil -> {:error, Error.user_not_found()}
      user -> validate_and_update(user, params)
    end
  end

  defp validate_and_update(user, params) do
    user
    |> User.update_changeset(params)
    |> Repo.update()
  end
end
