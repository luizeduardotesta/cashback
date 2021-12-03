defmodule CashbackWeb.RuleController do
  use CashbackWeb, :controller

  alias Cashback.Rules
  alias Cashback.Rules.Rule

  action_fallback CashbackWeb.FallbackController

  def create(conn, %{"rule" => rule_params}) do
    with {:ok, %Rule{} = rule} <- Rules.create(rule_params) do
      conn
      |> put_status(201)
      |> render("show.json", rule: rule)
    end
  end
end
