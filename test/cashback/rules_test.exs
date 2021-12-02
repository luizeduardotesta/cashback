defmodule Cashback.RulesTest do
  use Cashback.DataCase

  alias Cashback.Rules

  describe "rules" do
    alias Cashback.Rules.Rule

    import Cashback.RulesFixtures

    @invalid_attrs %{bonus: nil, description: nil}

    test "list/0 returns all rules" do
      rule = rule_fixture()
      assert Rules.list() == [rule]
    end

    test "get!/1 returns the rule with given id" do
      rule = rule_fixture()
      assert Rules.get!(rule.id) == rule
    end

    test "create/1 with valid data creates a rule" do
      valid_attrs = %{bonus: 42, description: "some description"}

      assert {:ok, %Rule{} = rule} = Rules.create(valid_attrs)
      assert rule.bonus == 42
      assert rule.description == "some description"
    end

    test "create/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Rules.create(@invalid_attrs)
    end

    test "update/2 with valid data updates the rule" do
      rule = rule_fixture()
      update_attrs = %{bonus: 43, description: "some updated description"}

      assert {:ok, %Rule{} = rule} = Rules.update(rule, update_attrs)
      assert rule.bonus == 43
      assert rule.description == "some updated description"
    end

    test "update/2 with invalid data returns error changeset" do
      rule = rule_fixture()
      assert {:error, %Ecto.Changeset{}} = Rules.update(rule, @invalid_attrs)
      assert rule == Rules.get!(rule.id)
    end

    test "delete/1 deletes the rule" do
      rule = rule_fixture()
      assert {:ok, %Rule{}} = Rules.delete(rule)
      assert_raise Ecto.NoResultsError, fn -> Rules.get!(rule.id) end
    end

    test "change/1 returns a rule changeset" do
      rule = rule_fixture()
      assert %Ecto.Changeset{} = Rules.change(rule)
    end
  end
end
