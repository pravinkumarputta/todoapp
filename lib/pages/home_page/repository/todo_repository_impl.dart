import 'package:sqflite/sqflite.dart';
import 'package:todoapp/constants/db.dart';
import 'package:todoapp/pages/home_page/models/todo_item.dart';

import 'repository.dart';

class TodoRepositoryImpl extends TodoRepository {
  late Database db;

  @override
  Future close() async => db.close();

  @override
  Future<int> delete(int id) async {
    return await db.delete(tableTodo, where: '$columnId = ?', whereArgs: [id]);
  }

  @override
  Future<List<TodoItem>> getAllTodos() async {
    List<Map<String, dynamic>> maps = await db.query(tableTodo, columns: [columnId, columnDone, columnTitle, columnPosition]);
    return maps.map<TodoItem>((e) => TodoItem.fromMap(e)).toList();
  }

  @override
  Future<TodoItem?> getTodo(int id) async {
    List<Map<String, dynamic>> maps = await db.query(tableTodo, columns: [columnId, columnDone, columnTitle, columnPosition], where: '$columnId = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return TodoItem.fromMap(maps.first);
    }
    return null;
  }

  @override
  Future<TodoItem> insert(TodoItem todoItem) async {
    todoItem.id = await db.insert(tableTodo, todoItem.toMap());
    return todoItem;
  }

  @override
  Future open() async {
    db = await openDatabase('my_db.db', version: 1, onCreate: (Database db, int version) async {
      await db.execute('''
  create table $tableTodo ( 
  $columnId integer primary key autoincrement, 
  $columnTitle text not null,
  $columnDone integer not null,
  $columnPosition integer not null)
''');
      await db.insert(tableTodo, TodoItem(null, 'Tap on plus to create new item', false).toMap());
      await db.insert(tableTodo, TodoItem(null, 'Swipe right to mark item done', false).toMap());
      await db.insert(tableTodo, TodoItem(null, 'Swipe left to delete item', false).toMap());
      await db.insert(tableTodo, TodoItem(null, 'Long press and drag up/down to change order', false).toMap());
    });
  }

  @override
  Future<int> update(TodoItem todoItem) async {
    return await db.update(tableTodo, todoItem.toMap(), where: '$columnId = ?', whereArgs: [todoItem.id]);
  }

  @override
  Future<int> updateOrder(List<int> updatedTodoOrder) async {
    for (int index = 0; index < updatedTodoOrder.length; index++) {
      await db.update(tableTodo, {columnPosition: index}, where: '$columnId = ?', whereArgs: [updatedTodoOrder[index]]);
    }
    return 1;
  }
}
