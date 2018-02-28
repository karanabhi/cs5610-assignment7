defmodule Tracker.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Tracker.Repo

  alias Tracker.Accounts.User

  @doc """
  Returns the list of users.

  ## Examples

  iex> list_users()
  [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

  iex> get_user!(123)
  %User{}

  iex> get_user!(456)
  ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

  iex> create_user(%{field: value})
  {:ok, %User{}}

  iex> create_user(%{field: bad_value})
  {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

  iex> update_user(user, %{field: new_value})
  {:ok, %User{}}

  iex> update_user(user, %{field: bad_value})
  {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

  iex> delete_user(user)
  {:ok, %User{}}

  iex> delete_user(user)
  {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

  iex> change_user(user)
  %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  # We want a non-bang variant
  def get_user(id), do: Repo.get(User, id)

  # And we want by-email lookup
  def get_user_by_email(email) do
    Repo.get_by(User, email: email)
  end

  alias Tracker.Accounts.Manage

  @doc """
  Returns the list of manages.

  ## Examples

  iex> list_manages()
  [%Manage{}, ...]

  """
  def list_manages do
    Repo.all(Manage)
  end

  @doc """
  Gets a single manage.

  Raises `Ecto.NoResultsError` if the Manage does not exist.

  ## Examples

  iex> get_manage!(123)
  %Manage{}

  iex> get_manage!(456)
  ** (Ecto.NoResultsError)

  """
  def get_manage!(id), do: Repo.get!(Manage, id)

  @doc """
  Creates a manage.

  ## Examples

  iex> create_manage(%{field: value})
  {:ok, %Manage{}}

  iex> create_manage(%{field: bad_value})
  {:error, %Ecto.Changeset{}}

  """
  def create_manage(attrs \\ %{}) do
    %Manage{}
    |> Manage.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a manage.

  ## Examples

  iex> update_manage(manage, %{field: new_value})
  {:ok, %Manage{}}

  iex> update_manage(manage, %{field: bad_value})
  {:error, %Ecto.Changeset{}}

  """
  def update_manage(%Manage{} = manage, attrs) do
    manage
    |> Manage.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Manage.

  ## Examples

  iex> delete_manage(manage)
  {:ok, %Manage{}}

  iex> delete_manage(manage)
  {:error, %Ecto.Changeset{}}

  """
  def delete_manage(%Manage{} = manage) do
    Repo.delete(manage)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking manage changes.

  ## Examples

  iex> change_manage(manage)
  %Ecto.Changeset{source: %Manage{}}

  """
  def change_manage(%Manage{} = manage) do
    Manage.changeset(manage, %{})
  end

  def manages_map_for(user_id) do
    Repo.all(from f in Manage,
    where: f.manager_id == ^user_id)
    |> Enum.map(&({&1.subordinate_id, &1.id}))
    |> Enum.into(%{})
  end

  def get_manager(userId) do
    Repo.get_by(Manage, subordinate_id: userId)
  end

  alias Tracker.Accounts.Time_Block

  @doc """
  Returns the list of time_blocks.

  ## Examples

  iex> list_time_blocks()
  [%Time_Block{}, ...]

  """
  def list_time_blocks do
    Repo.all(Time_Block)
  end

  @doc """
  Gets a single time__block.

  Raises `Ecto.NoResultsError` if the Time  block does not exist.

  ## Examples

  iex> get_time__block!(123)
  %Time_Block{}

  iex> get_time__block!(456)
  ** (Ecto.NoResultsError)

  """
  def get_time__block!(id), do: Repo.get!(Time_Block, id)

  def get_time__block(id), do: Repo.get(Time_Block, id)

  def get_time_block_by_task_id(tid) do
    Repo.get_by(Time_Block, task_id: tid)
  end


  @doc """
  Creates a time__block.

  ## Examples

  iex> create_time__block(%{field: value})
  {:ok, %Time_Block{}}

  iex> create_time__block(%{field: bad_value})
  {:error, %Ecto.Changeset{}}

  """
  def create_time__block(attrs \\ %{}) do
    %Time_Block{}
    |> Time_Block.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a time__block.

  ## Examples

  iex> update_time__block(time__block, %{field: new_value})
  {:ok, %Time_Block{}}

  iex> update_time__block(time__block, %{field: bad_value})
  {:error, %Ecto.Changeset{}}

  """
  def update_time__block(%Time_Block{} = time__block, attrs) do
    time__block
    |> Time_Block.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Time_Block.

  ## Examples

  iex> delete_time__block(time__block)
  {:ok, %Time_Block{}}

  iex> delete_time__block(time__block)
  {:error, %Ecto.Changeset{}}

  """
  def delete_time__block(%Time_Block{} = time__block) do
    Repo.delete(time__block)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking time__block changes.

  ## Examples

  iex> change_time__block(time__block)
  %Ecto.Changeset{source: %Time_Block{}}

  """
  def change_time__block(%Time_Block{} = time__block) do
    Time_Block.changeset(time__block, %{})
  end
end
