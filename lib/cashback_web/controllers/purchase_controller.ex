defmodule CashbackWeb.PurchaseController do
  use CashbackWeb, :controller

  alias Cashback.Purchases
  alias Cashback.Purchases.Purchase

  action_fallback CashbackWeb.FallbackController

  def create(conn, %{"purchase" => purchase_params}) do
    with {:ok, %Purchase{} = purchase} <- Purchases.create(purchase_params) do
      conn
      |> put_status(201)
      |> render("show.json", purchase: purchase)
    end
  end

  def index(conn, _params) do
    conn
    |> render("index.json", purchases: Purchases.list)
  end
end
