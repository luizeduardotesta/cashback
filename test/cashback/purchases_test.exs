defmodule Cashback.PurchasesTest do
  use Cashback.DataCase

  alias Cashback.Purchases

  describe "purchases" do
    alias Cashback.Purchases.Purchase

    import Cashback.PurchasesFixtures
    import Cashback.RulesFixtures

    @invalid_attrs %{price: nil, user_cpf: nil}

    test "list/0 returns all purchases" do
      purchase = purchase_fixture()
      assert Purchases.list() == [purchase]
    end

    test "get!/1 returns the purchase with given id" do
      purchase = purchase_fixture()
      assert Purchases.get!(purchase.id) == purchase
    end

    test "create/1 with valid data creates a purchase" do
      valid_attrs = %{price: 42, user_cpf: "some user_cpf", rule_id: rule_fixture().id}

      assert {:ok, %Purchase{} = purchase} = Purchases.create(valid_attrs)
      assert purchase.price == 42
      assert purchase.user_cpf == "some user_cpf"
      assert purchase.rule_id == valid_attrs.rule_id
    end

    test "create/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Purchases.create(@invalid_attrs)
    end

    test "update/2 with valid data updates the purchase" do
      purchase = purchase_fixture()
      update_attrs = %{price: 43, user_cpf: "some updated user_cpf"}

      assert {:ok, %Purchase{} = purchase} = Purchases.update(purchase, update_attrs)
      assert purchase.price == 43
      assert purchase.user_cpf == "some updated user_cpf"
    end

    test "update/2 with invalid data returns error changeset" do
      purchase = purchase_fixture()
      assert {:error, %Ecto.Changeset{}} = Purchases.update(purchase, @invalid_attrs)
      assert purchase == Purchases.get!(purchase.id)
    end

    test "delete/1 deletes the purchase" do
      purchase = purchase_fixture()
      assert {:ok, %Purchase{}} = Purchases.delete(purchase)
      assert_raise Ecto.NoResultsError, fn -> Purchases.get!(purchase.id) end
    end

    test "change/1 returns a purchase changeset" do
      purchase = purchase_fixture()
      assert %Ecto.Changeset{} = Purchases.change(purchase)
    end
  end
end
