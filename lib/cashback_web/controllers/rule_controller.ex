defmodule CashbackWeb.RulesController do
  use CashbackWeb, :controller

  action_fallback CashbackWeb.FallbackController

  def create(conn, params) do
    conn
    |> put_status(201)
    |> json(%{msg: params})
  end
end
