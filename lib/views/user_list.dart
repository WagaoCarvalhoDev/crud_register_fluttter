import 'package:crud_register/components/user_tile.dart';
import 'package:crud_register/riverpod/user_state.dart';
import 'package:crud_register/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserList extends ConsumerWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(userState);
    //print(users.values.first.name);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('Lista de usuários2'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.userForm);
              },
              icon: const Icon(Icons.add),
            )
          ],
        ),
        body: ListView.builder(
          itemCount: users.count,
          itemBuilder: (context, index) => UserTile(
            user: users.byIndex(index),
          ),
        ));
  }
}
