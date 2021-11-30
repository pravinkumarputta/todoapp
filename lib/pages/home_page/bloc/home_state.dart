import 'package:equatable/equatable.dart';
import 'package:todoapp/pages/home_page/models/todo_item.dart';

class HomeState extends Equatable {
  // state params
  final bool? isDBReady;
  final List<TodoItem>? todoList;

  const HomeState({
    this.todoList,
    this.isDBReady,
  });

  @override
  List<Object> get props => [isDBReady!,todoList!];

  HomeState copyWith({
    todoList,
    isDBReady,
    updateCount,
  }) {
    return HomeState(
      todoList: todoList ?? this.todoList,
      isDBReady: isDBReady ?? this.isDBReady,
    );
  }

  factory HomeState.empty() {
    return const HomeState(
      todoList: [],
      isDBReady: false,
    );
  }
}
