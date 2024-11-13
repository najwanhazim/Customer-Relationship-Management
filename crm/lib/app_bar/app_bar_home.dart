import 'package:flutter/material.dart';

class AppBarHome extends StatefulWidget {
  const AppBarHome({super.key});

  @override
  State<AppBarHome> createState() => _AppBarHomeState();
}

class _AppBarHomeState extends State<AppBarHome> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
    elevation: 0.0,
    backgroundColor: Colors.red[900],
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.notifications,
        ),
      ),
      const CircleAvatar(
        radius: 15,
        backgroundImage: NetworkImage(
            'https://www.google.com/imgres?q=profile&imgurl=https%3A%2F%2Fstatic.vecteezy.com%2Fsystem%2Fresources%2Fpreviews%2F003%2F715%2F527%2Fnon_2x%2Fpicture-profile-icon-male-icon-human-or-people-sign-and-symbol-vector.jpg&imgrefurl=https%3A%2F%2Fwww.vecteezy.com%2Fvector-art%2F3715527-picture-profile-icon-male-icon-human-or-people-sign-and-symbol-vector&docid=jV8noe8xdKAwbM&tbnid=3nPRi6_QfknfYM&vet=12ahUKEwiLuJX539WJAxXUSmwGHcRzBiIQM3oECFoQAA..i&w=980&h=980&hcb=2&ved=2ahUKEwiLuJX539WJAxXUSmwGHcRzBiIQM3oECFoQAA'),
      ),
    ],
  );
  }
}