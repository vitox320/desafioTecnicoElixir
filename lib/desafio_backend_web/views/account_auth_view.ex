defmodule DesafioBackendWeb.AccountAuthView do
  def render("account.json", %{account: account}) do
    %{id: account.id, email: account.email}
  end

  def render("login.json", %{account: account,token: token}) do
    %{
      data: %{
        account: %{
          id: account.id,
          email: account.email
        },
        token: token
      }
    }
  end
end
