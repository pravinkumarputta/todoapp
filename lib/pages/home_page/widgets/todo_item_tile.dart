import 'package:flutter/material.dart';
import 'package:todoapp/pages/home_page/models/todo_item.dart';

import 'widgets.dart';

class TodoItemTile extends StatelessWidget {
  final TodoItem todoItem;
  final Function(TodoItem item) onRightSwipe, onLeftSwipe;

  const TodoItemTile({Key? key, required this.todoItem, required this.onRightSwipe, required this.onLeftSwipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey<int>(todoItem.id!),
      child: ListTile(
        title: Text(
          todoItem.title,
          style: TextStyle(
            decoration: todoItem.done ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),
      ),
      background: const RightSwipeAction(),
      secondaryBackground: const LeftSwipeAction(),
      onDismissed: (direction) {
        onLeftSwipe(todoItem);
      },
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          onRightSwipe(todoItem);
          return false;
        } else {
          return true;
        }
      },
    );
  }
}
