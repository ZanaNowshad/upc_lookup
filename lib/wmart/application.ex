defmodule Wmart.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    if System.get_env("PORT") == nil, do: raise "Missing PORT environment variable"

    port = System.get_env("PORT")
           |> String.to_integer

    children = [
      { Task.Supervisor, name: Wmart.TaskSupervisor },
      { Task, fn -> Wmart.Server.open(port) end }
    ]

    opts = [strategy: :one_for_one, name: Wmart.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
