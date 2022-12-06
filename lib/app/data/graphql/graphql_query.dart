import 'package:graphql_flutter/graphql_flutter.dart';

final getTodosSubscription = gql('''
subscription  {
  todos(order_by: {name: desc}) {
    id
    created
    is_completed
    name
    updated
    user_id
  }
}
''');

final updateTodoStatus = gql(r'''
mutation($todo_id: uuid!, $is_completed: Boolean!) {
  update_todos_by_pk(
    pk_columns: {id: $todo_id }, 
  _set: {is_completed: $is_completed}) {
    id
  }
}
''');

final addTodo = gql(r''' 
mutation($todo: todos_insert_input!) {
  insert_todos(objects: [$todo]) {
    affected_rows
  }
}
''');

final getUserProfileSubscription = gql(''' 
subscription{
  users{
    id
    displayName
    avatarUrl
  }
}
''');
