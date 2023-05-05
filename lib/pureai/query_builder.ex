defmodule PureAI.QueryBuilder do
  @moduledoc false

  # require Timex

  import Ecto.Query, warn: false

  def filter_pack(queryable, filter) when is_map(filter) do
    Enum.reduce(filter, queryable, fn
      {:profile_token_id, profile_token_id}, queryable ->
        queryable |> where([p], p.profile_token_id == ^profile_token_id)

      {:profile_token_ids, profile_token_ids}, queryable ->
        queryable |> where([p], p.profile_token_id in ^profile_token_ids)

      {:topic, topic}, queryable ->
        queryable |> where([p], p.topic == ^topic)

      {:is_draft, is_draft}, queryable ->
        queryable |> where([p], p.is_draft == ^is_draft)

      {:sort, :desc_inserted}, queryable ->
        queryable |> order_by(desc: :inserted_at)

      {:sort, :asc_inserted}, queryable ->
        queryable |> order_by(asc: :inserted_at)

      {:sort, :most_views}, queryable ->
        queryable |> order_by(desc: :view_count, desc: :inserted_at)

      {:sort, :recommend}, queryable ->
        queryable |> order_by(desc: :position, desc: :inserted_at)

      {:sort, :least_views}, queryable ->
        queryable |> order_by(asc: :view_count, desc: :inserted_at)

      {:when, :today}, queryable ->
        # date = DateTime.utc_now() |> Timex.to_datetime()
        # use timezone info is server is not in the some timezone
        # Timex.now("America/Chicago")
        date = Timex.now()

        queryable
        |> where([p], p.inserted_at >= ^Timex.beginning_of_day(date))
        |> where([p], p.inserted_at <= ^Timex.end_of_day(date))

      {:when, :this_week}, queryable ->
        date = Timex.now()

        queryable
        |> where([p], p.inserted_at >= ^Timex.beginning_of_week(date))
        |> where([p], p.inserted_at <= ^Timex.end_of_week(date))

      {:when, :this_month}, queryable ->
        date = Timex.now()

        queryable
        |> where([p], p.inserted_at >= ^Timex.beginning_of_month(date))
        |> where([p], p.inserted_at <= ^Timex.end_of_month(date))

      {:when, :this_year}, queryable ->
        date = Timex.now()

        queryable
        |> where([p], p.inserted_at >= ^Timex.beginning_of_year(date))
        |> where([p], p.inserted_at <= ^Timex.end_of_year(date))

      {:first, first}, queryable ->
        queryable |> limit(^first)

      {:state, state}, queryable ->
        queryable |> where([p], p.state == ^state)

      {:is_deleted, true}, queryable ->
        queryable |> where([p], not is_nil(p.deleted_at))

      {:is_deleted, false}, queryable ->
        queryable |> where([p], is_nil(p.deleted_at))

      {_, _}, queryable ->
        queryable
    end)
  end
end
