import 'package:equatable/equatable.dart';
import 'package:todoapp/pages/home_page/models/todo_item.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddTodo extends HomeEvent {
  final TodoItem todoItem;

  AddTodo(this.todoItem);

  @override
  String toString() {
    return '''
    AddTodo(todoItem: $todoItem)
    ''';
  }
}

class RemoveTodo extends HomeEvent {
  final TodoItem todoItem;

  RemoveTodo(this.todoItem);

  @override
  String toString() {
    return '''
    RemoveTodo(todoItem: $todoItem)
    ''';
  }
}

class UpdateTodo extends HomeEvent {
  final TodoItem todoItem;

  UpdateTodo(this.todoItem);

  @override
  String toString() {
    return '''
    UpdateTodo(todoItem: $todoItem)
    ''';
  }
}

class UpdateOrder extends HomeEvent {
  final List<int> updateOrderOfIds;

  UpdateOrder(this.updateOrderOfIds);

  @override
  String toString() {
    return '''
    UpdateOrder(updateOrderOfIds: $updateOrderOfIds)
    ''';
  }
}

class FetchAllTodos extends HomeEvent {}
