import 'package:crud_register/riverpod/user_state.dart';
import 'package:crud_register/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user.dart';

class UserTile extends StatelessWidget {
  final User? user;

  const UserTile({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    final avatar = user!.avatarUrl.isEmpty
        ? const CircleAvatar(child: Icon(Icons.person))
        : CircleAvatar(backgroundImage: NetworkImage(user!.avatarUrl));
    return ListTile(
      leading: avatar,
      title: Text(user!.name),
      subtitle: Text(user!.email),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                AppRoutes.userForm,
                arguments: user,
              );
            },
            color: Colors.deepOrangeAccent,
            icon: const Icon(Icons.edit),
          ),
          Consumer(
            builder: (context, ref, child) {
              final users = ref.watch(userState);
              return IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Excluir usuário'),
                        content: const Text('Tem certeza?'),
                        actions: [
                          ElevatedButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text('Não')),
                          ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text('Sim'),
                          ),
                        ],
                      );
                    },
                  ).then((confirmed) {
                    if (confirmed) {
                      users.remove(user!);
                    }
                  });
                },
                color: Colors.redAccent,
                icon: const Icon(Icons.delete),
              );
            },
          ),
        ],
      ),
    );
  }
}
