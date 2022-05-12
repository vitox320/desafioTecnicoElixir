defmodule DesafioBackendWeb.Token do
  alias Phoenix.Token
  alias DesafioBackendWeb.Endpoint
  alias DesafioBackend.Account

  @salt "cumbuca_token"
  @ttl 86400

  def create(%Account{id: account_id}) do
    Token.sign(DesafioBackendWeb.Endpoint, @salt, %{account_id: account_id})
  end

  def verify(token) do
    case Token.verify(Endpoint, @salt, token, max_age: @ttl) do
      {:ok, _account_data} = response -> response
      _error -> {:error, :unauthorized}
    end
  end
end
