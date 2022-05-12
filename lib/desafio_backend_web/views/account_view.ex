defmodule DesafioBackendWeb.AccountView do
  use DesafioBackendWeb, :view

  def render("index.json", %{account: account}) do
    %{user: render_many(account, __MODULE__, "index_view.json")}
  end

  def render("account.json", %{account: account}) do
    %{
      account: %{
        id: account.id,
        name: account.name,
        surname: account.surname,
        email: account.email,
        cpf: account.cpf,
        initial_balance: account.initial_balance,
        date_create: account.date_create,
      }
    }
  end

  def render("index_view.json", %{account: account}) do
    %{
      account: %{
        id: account.id,
        name: account.name,
        surname: account.surname,
        email: account.email,
        cpf: account.cpf,
        initial_balance: account.initial_balance,
        date_create: account.date_create
      }
    }
  end

  def render("balance.json", %{account: account}) do
    %{
      account: %{
        balance: account.initial_balance,
      }
    }
  end
end
