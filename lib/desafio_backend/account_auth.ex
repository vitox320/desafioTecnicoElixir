defmodule DesafioBackend.AccountAuth do
  import Ecto.Query, only: [from: 2]
  alias DesafioBackend.Repo
  alias DesafioBackend.Account

  def change_account(%Account{} = account) do
    Account.changeset(account, %{})
  end

  def authenticate_account(params) do
    query = from(acc in Account, where: acc.email == ^params["email"])
    query |> Repo.one() |> verify_password(params["password"])
  end

  defp verify_password(nil, _) do
    # Perform a dummy check to make user enumeration more difficult
    Bcrypt.no_user_verify()
    {:error, "Wrong email or password"}
  end

  defp verify_password(user, password) do
    if Bcrypt.verify_pass(password, user.password_hash) do
      {:ok, user}
    else
      {:error, "Wrong email or password"}
    end
  end


end
