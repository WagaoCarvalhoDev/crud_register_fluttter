import 'package:crud_register/models/user.dart';
import 'package:crud_register/riverpod/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserForm extends StatefulWidget {
  const UserForm({super.key});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();

  final Map<String, String> _formData = {};

  void _loadFormData(User user) {
    _formData['id'] = user.id!;
    _formData['name'] = user.name;
    _formData['email'] = user.email;
    _formData['avatarUrl'] = user.avatarUrl;
  }

  @override
  void didChangeDependencies() {
    if (ModalRoute
        .of(context)!
        .settings
        .arguments != null) {
      final user = ModalRoute
          .of(context)!
          .settings
          .arguments as User;
      _loadFormData(user);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de usuário'),
        actions: [
          Consumer(
            builder: (context, ref, child) {
              final users = ref.watch(userState);
              return IconButton(
                  onPressed: () {
                    final isValid = _form.currentState!.validate();

                    if (isValid) {
                      _form.currentState!.save();
                      users.put(User(
                        id: _formData['id'],
                        name: _formData['name'].toString(),
                        email: _formData['email'].toString(),
                        avatarUrl: _formData['avatarUrl'].toString(),
                      ));
                      Navigator.of(context).pop();
                    }
                  },
                  icon: const Icon(Icons.save));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(
                initialValue: _formData['name'],
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nome inválido';
                  }
                  if (value
                      .trim()
                      .length < 3) {
                    return 'Mínimo de 3 caracteres';
                  }
                  return null;
                },
                onSaved: (newValue) => _formData['name'] = newValue!,
              ),
              TextFormField(
                initialValue: _formData['email'],
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nome inválido';
                  }
                  if (value
                      .trim()
                      .length < 3) {
                    return 'Mínimo de 3 caracteres';
                  }
                  return null;
                },
                onSaved: (newValue) => _formData['email'] = newValue!,
              ),
              TextFormField(
                initialValue: _formData['avatarUrl'],
                decoration: const InputDecoration(labelText: 'URL do Avatar'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nome inválido';
                  }
                  if (value
                      .trim()
                      .length < 3) {
                    return 'Mínimo de 3 caracteres';
                  }
                  return null;
                },
                onSaved: (newValue) => _formData['avatarUrl'] = newValue!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
