defmodule Overbooked.Resources do
  @moduledoc """
  The Resources context.
  """

  import Ecto.Query, warn: false
  alias Overbooked.Repo

  alias Overbooked.Resources.{Resource, ResourceType}

  def get_resource_type_by_name!(name), do: Repo.get_by!(ResourceType, name: name)

  @doc """
  Returns the list of resources.

  ## Examples

      iex> list_resources()
      [%Resource{}, ...]

  """
  def list_resources do
    Repo.all(Resource)
  end

  def list_rooms(opts \\ []) do
    from(r in Resource,
      limit: ^Keyword.get(opts, :limit, 100),
      join: rt in ResourceType,
      on: rt.id == r.resource_type_id,
      where: rt.name == "room",
      group_by: r.id
    )
    |> Repo.all()
  end

  def list_desks(opts \\ []) do
    from(r in Resource,
      limit: ^Keyword.get(opts, :limit, 100),
      join: rt in ResourceType,
      on: rt.id == r.resource_type_id,
      where: rt.name == "desk",
      group_by: r.id
    )
    |> Repo.all()
  end

  @doc """
  Gets a single resource.

  Raises `Ecto.NoResultsError` if the Resource does not exist.

  ## Examples

      iex> get_resource!(123)
      %Resource{}

      iex> get_resource!(456)
      ** (Ecto.NoResultsError)

  """
  def get_resource!(id), do: Repo.get!(Resource, id)

  @doc """
  Creates a resource.

  ## Examples

      iex> create_resource(resource_type, %{field: value})
      {:ok, %Resource{}}

      iex> create_resource(resource_type, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_resource(%ResourceType{} = resource_type, attrs \\ %{}) do
    %Resource{}
    |> Resource.changeset(attrs)
    |> Resource.put_resource_type(resource_type)
    |> Repo.insert()
  end

  def create_desk(attrs \\ %{}) do
    resource_type = get_resource_type_by_name!("desk")

    create_resource(resource_type, attrs)
  end

  def create_room(attrs \\ %{}) do
    resource_type = get_resource_type_by_name!("room")

    create_resource(resource_type, attrs)
  end

  @doc """
  Updates a resource.

  ## Examples

      iex> update_resource(resource, %{field: new_value})
      {:ok, %Resource{}}

      iex> update_resource(resource, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_resource(%Resource{} = resource, attrs) do
    resource
    |> Resource.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a resource.

  ## Examples

      iex> delete_resource(resource)
      {:ok, %Resource{}}

      iex> delete_resource(resource)
      {:error, %Ecto.Changeset{}}

  """
  def delete_resource(%Resource{} = resource) do
    Repo.delete(resource)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking resource changes.

  ## Examples

      iex> change_resource(resource)
      %Ecto.Changeset{data: %Resource{}}

  """
  def change_resource(%Resource{} = resource, attrs \\ %{}) do
    Resource.changeset(resource, attrs)
  end
end
