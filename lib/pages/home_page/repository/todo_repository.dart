import 'package:todoapp/pages/home_page/models/todo_item.dart';

abstract class TodoRepository {
  Future open();
  Future close();
  Future<TodoItem> insert(TodoItem todoItem);
  Future<TodoItem?> getTodo(int id);
  Future<List<TodoItem>> getAllTodos();
  Future<int> delete(int id);
  Future<int> update(TodoItem todoItem);
  Future<int> updateOrder(List<int> updatedTodoOrder);
}
