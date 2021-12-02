defmodule Cashback.RulesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Cashback.Rules` context.
  """

  @doc """
  Generate a rule.
  """
  def rule_fixture(attrs \\ %{}) do
    {:ok, rule} =
      attrs
      |> Enum.into(%{
        bonus: 42,
        description: "some description"
      })
      |> Cashback.Rules.create()

    rule
  end
end
