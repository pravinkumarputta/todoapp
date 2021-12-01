import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:todoapp/pages/home_page/bloc/bloc.dart';
import 'package:todoapp/pages/home_page/models/todo_item.dart';
import 'package:todoapp/pages/home_page/repository/repository.dart';
import 'package:todoapp/pages/home_page/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static route() => 'HomePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBloc _homeBloc;
  late SearchBar searchBar;

  AppBar buildAppBar(BuildContext context) {
    return AppBar(title: const Text('To Do'), actions: [IconButton(onPressed: searchBar.getSearchAction(context).onPressed, icon: const Icon(Icons.add))]);
  }

  _HomePageState() {
    searchBar = SearchBar(
      inBar: false,
      setState: setState,
      onSubmitted: _onAddNewItem,
      buildDefaultAppBar: buildAppBar,
      showClearButton: false,
      hintText: 'Add new item',
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // init bloc
    _homeBloc = HomeBloc(TodoRepositoryImpl());

    // fetch all todos
    _homeBloc.add(FetchAllTodos());
  }

  @override
  void dispose() {
    _homeBloc.close();
    super.dispose();
  }

  _onAddNewItem(text) async {
    _homeBloc.add(AddTodo(TodoItem(null, text, false)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchBar.build(context),
      body: BlocProvider<HomeBloc>(
        create: (_) => _homeBloc,
        child: BlocBuilder<HomeBloc, HomeState>(
          bloc: _homeBloc,
          builder: (context, state) {
            return ReorderableListView.builder(
              itemBuilder: (context, index) {
                return TodoItemTile(
                  key: ValueKey<int>(state.todoList![index].id!),
                  todoItem: state.todoList![index],
                  onRightSwipe: (todoItem) {
                    _homeBloc.add(UpdateTodo(TodoItem(todoItem.id, todoItem.title, true)));
                  },
                  onLeftSwipe: (todoItem) {
                    _homeBloc.add(RemoveTodo(todoItem));
                  },
                );
              },
              itemCount: state.todoList!.length,
              onReorder: (oldIndex, newIndex) {
                if (newIndex > oldIndex) {
                  newIndex = newIndex - 1;
                }
                List<int> currentOrder = state.todoList!.map((e) => e.id!).toList();
                var element = currentOrder.removeAt(oldIndex);
                var item = state.todoList!.removeAt(oldIndex);
                currentOrder.insert(newIndex, element);
                state.todoList!.insert(newIndex, item);

                // save new order to db
                _homeBloc.add(UpdateOrder(currentOrder));
              },
            );
          },
        ),
      ),
    );
  }
}
