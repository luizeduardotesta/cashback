defmodule Cashback.Purchases do
  @moduledoc """
  The Purchases context.
  """

  import Ecto.Query, warn: false
  alias Cashback.Repo

  alias Cashback.Purchases.Purchase

  @doc """
  Returns the list of purchases.

  ## Examples

      iex> list()
      [%Purchase{}, ...]

  """
  def list do
    Repo.all(Purchase)
  end

  @doc """
  Gets a single purchase.

  Raises `Ecto.NoResultsError` if the Purchase does not exist.

  ## Examples

      iex> get!(123)
      %Purchase{}

      iex> get!(456)
      ** (Ecto.NoResultsError)

  """
  def get!(id), do: Repo.get!(Purchase, id)

  @doc """
  Creates a purchase.

  ## Examples

      iex> create(%{field: value})
      {:ok, %Purchase{}}

      iex> create(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create(attrs \\ %{}) do
    %Purchase{}
    |> Purchase.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a purchase.

  ## Examples

      iex> update(purchase, %{field: new_value})
      {:ok, %Purchase{}}

      iex> update(purchase, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update(%Purchase{} = purchase, attrs) do
    purchase
    |> Purchase.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a purchase.

  ## Examples

      iex> delete(purchase)
      {:ok, %Purchase{}}

      iex> delete(purchase)
      {:error, %Ecto.Changeset{}}

  """
  def delete(%Purchase{} = purchase) do
    Repo.delete(purchase)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking purchase changes.

  ## Examples

      iex> change(purchase)
      %Ecto.Changeset{data: %Purchase{}}

  """
  def change(%Purchase{} = purchase, attrs \\ %{}) do
    Purchase.changeset(purchase, attrs)
  end

  @doc """
  Returns a cashback calculation.

  """
  @spec calc_cashback(Integer.t(), Integer.t()) :: Float.t()
  def calc_cashback(price, bonus), do: price * (bonus / 100)

  @doc """
    Generates a code for cashback based on id and user_cpf from a purchase.
  """
  @spec gen_code(Integer.t() | String.t(), String.t()) :: binary()
  def gen_code(id, cpf), do: :crypto.hash(:md5, "#{id} #{cpf}") |> Base.encode16()
end
