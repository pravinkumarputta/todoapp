import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/pages/home_page/models/todo_item.dart';
import 'package:todoapp/pages/home_page/repository/repository.dart';

import 'bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final TodoRepository todoRepository;

  HomeBloc(this.todoRepository) : super(HomeState.empty()) {
    // map events
    on<AddTodo>(_onAddTodo, transformer: sequential());
    on<RemoveTodo>(_onRemoveTodo, transformer: sequential());
    on<UpdateTodo>(_onUpdateTodo, transformer: sequential());
    on<FetchAllTodos>(_onFetchAllTodos, transformer: sequential());
    on<UpdateOrder>(_onUpdateOrder, transformer: sequential());
  }

  _onAddTodo(AddTodo event, Emitter<HomeState> emit) async {
    // open database
    await todoRepository.open();

    // insert to db
    await todoRepository.insert(event.todoItem);

    // close database
    await todoRepository.close();

    // update state
    await _onFetchAllTodos(FetchAllTodos(), emit);
  }

  _onRemoveTodo(RemoveTodo event, Emitter<HomeState> emit) async {
    // open database
    await todoRepository.open();

    // remove from db
    await todoRepository.delete(event.todoItem.id!);

    // close database
    await todoRepository.close();

    // update state
    await _onFetchAllTodos(FetchAllTodos(), emit);
  }

  _onUpdateTodo(UpdateTodo event, Emitter<HomeState> emit) async {
    // open database
    await todoRepository.open();

    // update to db
    await todoRepository.update(event.todoItem);

    // close database
    await todoRepository.close();

    // update state
    await _onFetchAllTodos(FetchAllTodos(), emit);
  }

  _onUpdateOrder(UpdateOrder event, Emitter<HomeState> emit) async {
    // open database
    await todoRepository.open();

    // update to db
    await todoRepository.updateOrder(event.updateOrderOfIds);

    // close database
    await todoRepository.close();

    // update state
    await _onFetchAllTodos(FetchAllTodos(), emit);
  }

  _onFetchAllTodos(FetchAllTodos event, Emitter<HomeState> emit) async {
    // open database
    await todoRepository.open();

    // fetch all from db
    List<TodoItem> todoItems = await todoRepository.getAllTodos();

    // close database
    await todoRepository.close();

    // move all done items to the last
    todoItems.sort((a, b) {
      return a.position - b.position;
    });

    // update state
    emit(state.copyWith(todoList: todoItems));
  }
}
