defmodule LiveViewTodosWeb.TodoLive do
  use LiveViewTodosWeb, :live_view
  alias LiveViewTodos.Todos

  def mount(_params, _session, socket) do
    Todos.subscribe()

    {:ok, assign(socket, todos: Todos.list_todos())}
  end
  def handle_event("add", %{"todo"=> todo}, socket) do
    Todos.create_todo(todo)
    {:noreply, assign(socket, todos: Todos.list_todos()) }
  end

  def handle_info({Todos, [:todo | _], _}, socket) do
    {:noreply, assign(socket, todos: Todos.list_todos())}
  end
  def handle_event("toggle_done", %{"id" => id}, socket) do
    todo = Todos.get_todo!(id)
    Todos.update_todo(todo, %{done: !todo.done})
    {:noreply, assign(socket, todos: Todos.list_todos())}
  end
end
