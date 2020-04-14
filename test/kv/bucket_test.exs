defmodule KV.BucketTest do
  use ExUnit.Case, async: true

  setup do
    bucket = start_supervised!(KV.Bucket)
    %{bucket: bucket}
  end

  test "test bucket is empty", %{bucket: bucket} do
    assert KV.Bucket.get(bucket, "milk") == nil
  end

  test "test bucket get", %{bucket: bucket} do
    KV.Bucket.put(bucket, "milk", 3)
    assert KV.Bucket.get(bucket, "milk") == 3
  end

  test "test bucket.delete returns", %{bucket: bucket} do
    KV.Bucket.put(bucket, "vodka", 42)
    assert KV.Bucket.delete(bucket, "vodka") == 42
  end

  test "test bucket.delete deletes", %{bucket: bucket} do
    KV.Bucket.put(bucket, "vodka", 42)
    KV.Bucket.delete(bucket, "vodka")
    assert KV.Bucket.get(bucket, "vodka") == nil
  end

  test "are temporary workerks" do
    assert Supervisor.child_spec(KV.Bucket, []).restart == :temporary
  end
end
