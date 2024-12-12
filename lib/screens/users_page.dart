import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users_cubit/cubit/users_cubit.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Users"),
      ),
      body: BlocBuilder<UsersCubit, UsersState>(
        builder: (context, state) {
          return state.when(
            initial: () => Center(
              child: ElevatedButton(
                onPressed: () => context.read<UsersCubit>().fetchUsers(),
                child: const Text("Get Users"),
              ),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            success: (users) {
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(users[index].name),
                    subtitle: Text(users[index].email),
                  );
                },
              );
            },
            error: (errorMessage) => Center(
              child: Text(errorMessage),
            ),
          );
        },
      ),
    );
  }
}
