defmodule KV.Bucket do
  use Agent

  @doc """
  Starts a new bucket.
  """
  def start_link(_opts) do
    Agent.start_link(fn -> %{} end)
  end

  @doc """
  Gets a value from the `bucket` by `key`.
  """
  def put(bucket, key, value) do
    Agent.update(bucket, &Map.__info__put(&1, key, value))
  end
end
