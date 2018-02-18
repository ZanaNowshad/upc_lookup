require Logger

defmodule Wmart.Server do
  alias Wmart.Parser

  def open(port) do
    {:ok, socket} = :gen_tcp.listen(port,
                      [:binary, packet: :line, active: false, reuseaddr: true])
    Logger.info "Starting server listening on port #{port}"
    loop_acceptor(socket)
  end

  defp loop_acceptor(socket) do
    Logger.info "Accepting connections..."
    {:ok, client} = :gen_tcp.accept(socket)
    {:ok, pid} = Task.Supervisor.start_child(Wmart.TaskSupervisor, fn -> serve(client) end)
    :ok = :gen_tcp.controlling_process(client, pid)
    loop_acceptor(socket)
  end

  defp serve(socket) do
    socket
    |> read_line()
    |> Parser.parse()
    |> write_line(socket)

    serve(socket)
  end

  defp read_line(socket) do
    case :gen_tcp.recv(socket, 0) do
      {:ok, data} ->
        String.trim(data)
      {:error, :closed} ->
        Logger.info "Connection went away"
    end
  end

  defp write_line(line, socket) do
    :gen_tcp.send(socket, "\r#{line}\r\n")
  end
end
