defmodule PureAI.Turbo do
  @moduledoc """
  Ecto Enhance API
  """

  import Ecto.Query, warn: false

  alias PureAI.Repo
  alias PureAI.QueryBuilder

  def find_all(queryable, filter) do
    queryable
    |> QueryBuilder.filter_pack(filter)
    |> paginator(filter)
    |> done()
  end

  @doc """
  Finds a object by it's id.
  """
  def get(queryable, id, preload: preload) do
    queryable
    |> preload(^preload)
    |> Repo.get(id)
    |> done(queryable, id)
  end

  def get(queryable, id) do
    queryable
    |> Repo.get(id)
    |> done(queryable, id)
  end

  @doc """
  simular to Repo.get_by/3, with standard result/error handle
  """
  def get_by(queryable, clauses, preload: preload) do
    queryable
    |> preload(^preload)
    |> Repo.get_by(clauses)
    |> case do
      nil ->
        {:error, :not_found}

      result ->
        {:ok, result}
    end
  end

  def get_by(queryable, clauses) do
    queryable
    |> Repo.get_by(clauses)
    |> case do
      nil ->
        {:error, :not_found}

      result ->
        {:ok, result}
    end
  end

  @doc """
  Creates a object.
  """
  def create(schema, attrs) do
    schema
    |> struct
    |> schema.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a object.
  """
  def update(content, attrs) do
    content
    |> content.__struct__.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a object.
  """
  def delete(content), do: Repo.delete(content)

  @doc "findby & delete"
  def findby_delete(queryable, clauses) do
    case get_by(queryable, clauses) do
      {:ok, content} -> delete(content)
      _ -> {:ok, :pass}
    end
  end

  @doc """
  Soft Deletes a object.
  """

  def soft_delete(content), do: __MODULE__.update(content, %{deleted_at: DateTime.utc_now()})

  @doc """
  Require queryable has a views fields to count the views of the queryable Modal
  """
  def read(queryable, id, preload) do
    with {:ok, result} <- get(queryable, id, preload: preload) do
      result |> inc_view_count(queryable) |> done()
    end
  end

  def read_by(queryable, clauses, preload) do
    with {:ok, result} <- get_by(queryable, clauses, preload: preload) do
      result |> inc_view_count(queryable) |> done()
    end
  end

  defp inc_view_count(content, queryable) do
    {1, [result]} =
      Repo.update_all(
        from(p in queryable, where: p.id == ^content.id, select: p.view_count),
        inc: [view_count: 1]
      )

    put_in(content.view_count, result)
  end

  @doc "count current queryable"
  def count(queryable) do
    queryable |> Repo.aggregate(:count) |> done()
  end

  def update_meta(queryable, meta) do
    meta = meta |> strip_struct()

    queryable
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_embed(:metadata, meta)
    |> Repo.update()
  end

  @doc "mark read as true for all"
  def mark_read_all(queryable) do
    queryable
    |> Repo.update_all(set: [is_read: true])
    |> done()
  end

  def findby_or_insert(queryable, clauses, attrs) do
    case queryable |> get_by(clauses) do
      {:ok, content} ->
        {:ok, content}

      {:error, _} ->
        queryable |> create(attrs)
    end
  end

  @doc """
  update embed data
  """
  def update_embed(queryable, key, value, changes) do
    queryable
    |> Ecto.Changeset.change(changes)
    |> Ecto.Changeset.put_embed(key, value)
    |> Repo.update()
  end

  def update_embed(queryable, key, value) do
    queryable
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_embed(key, value)
    |> Repo.update()
  end

  @doc """
  convert struct to normal map and remove :id field
  """
  def strip_struct(struct) when is_struct(struct) do
    struct |> Map.from_struct() |> Map.delete(:id) |> Map.delete(:__meta__)
  end

  def strip_struct(map) when is_map(map), do: map

  @doc """
  offset-limit based pagination
  total_count is a personal-taste naming convert
  """
  def paginator(queryable, page: page, size: size), do: do_pagi(queryable, page, size)
  def paginator(queryable, page: page), do: do_pagi(queryable, page, 20)
  def paginator(queryable, %{page: page, size: size}), do: do_pagi(queryable, page, size)
  def paginator(queryable, %{page: page}), do: do_pagi(queryable, page, 20)
  def paginator(queryable, _), do: do_pagi(queryable, 1, 20)

  def blank_entries() do
    %{
      entries: [],
      page_info: %{
        page_number: 1,
        page_size: 20,
        total_entries: 0,
        total_pages: 0
      }
    }
  end

  defp do_pagi(queryable, page, size) do
    %{
      entries: entries,
      page_number: page_number,
      page_size: page_size,
      total_entries: total_entries,
      total_pages: total_pages
    } =
      Repo.paginate(queryable,
        page: page,
        page_size: size,
        options: [allow_overflow_page_number: true]
      )

    %{
      entries: entries,
      page_info: %{
        page_number: page_number,
        page_size: page_size,
        total_entries: total_entries,
        total_pages: total_pages
      }
    }
  end

  def done(nil), do: {:error, "record not found."}
  def done([]), do: {:ok, []}
  def done({n, nil}) when is_integer(n), do: {:ok, %{done: true}}
  def done(result), do: {:ok, result}
  def done(nil, _, _), do: {:error, "record not found."}
  def done(result, _, _), do: {:ok, result}
  def done({:ok, _}, with: result), do: {:ok, result}
  def done(nil, :boolean), do: {:ok, false}
  def done(_, :boolean), do: {:ok, true}
  def done(nil, err_msg), do: {:error, err_msg}
  def done({:error, _}, :status), do: {:ok, %{done: false}}
end
