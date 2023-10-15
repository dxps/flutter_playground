import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../app/svc.locator.dart';
import '../../models/todo.dart';
import '../../services/todos.svc.dart';

class TodosScreenViewModel extends ReactiveViewModel {
  final _firstTodoFocusNode = FocusNode();
  final _todosSvc = locator<TodosService>();
  late final toggleStatus = _todosSvc.toggleStatus;
  late final removeTodo = _todosSvc.removeTodo;
  late final updateTodoContent = _todosSvc.updateTodoContent;

  List<Todo> get todos => _todosSvc.todos;

  void newTodo() {
    _todosSvc.newTodo();
    _firstTodoFocusNode.requestFocus();
  }

  FocusNode? getFocusNode(String id) {
    final index = todos.indexWhere((todo) => todo.id == id);
    return index == 0 ? _firstTodoFocusNode : null;
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_todosSvc];
}
