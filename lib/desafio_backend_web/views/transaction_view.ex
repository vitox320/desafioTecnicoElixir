defmodule DesafioBackendWeb.TransactionView do
  use DesafioBackendWeb, :view

  def render("index.json", %{transaction: transaction}) do
    %{transaction: render_many(transaction, __MODULE__, "transaction.json")}
  end

  def render("transaction.json", %{transaction: transaction}) do
    %{
      transaction_value: transaction.transaction_value,
      data_processing: transaction.data_processing,
      identity_sender_account: transaction.identity_sender_account,
      identity_receiving_account: transaction.identity_receiving_account,
    }
  end

end
