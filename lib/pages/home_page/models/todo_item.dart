import 'package:equatable/equatable.dart';
import 'package:todoapp/constants/db.dart';

class TodoItem extends Equatable {
  int? id;
  late String title;
  late bool done;
  int position;

  TodoItem(this.id, this.title, this.done, {this.position = -1});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{columnTitle: title, columnDone: done == true ? 1 : 0, columnPosition: position};
    map[columnId] = id;
    return map;
  }

  static fromMap(Map<String, dynamic> map) {
    return TodoItem(
      map[columnId],
      map[columnTitle],
      map[columnDone] == 1,
      position: map[columnPosition],
    );
  }

  @override
  List<Object> get props => [id!, title, done, position];

  @override
  String toString() {
    return '''
    TodoItem({id: $id, title: $title, done: $done, position: $position})
    ''';
  }
}
