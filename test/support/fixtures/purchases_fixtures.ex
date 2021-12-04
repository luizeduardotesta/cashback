defmodule Cashback.PurchasesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Cashback.Purchases` context.
  """

  @doc """
  Generate a purchase.
  """
  def purchase_fixture(attrs \\ %{}) do
    {:ok, purchase} =
      attrs
      |> Enum.into(%{
        price: 42,
        user_cpf: "some user_cpf",
        rule_id: Cashback.RulesFixtures.rule_fixture().id
      })
      |> Cashback.Purchases.create()

    purchase
  end
end
