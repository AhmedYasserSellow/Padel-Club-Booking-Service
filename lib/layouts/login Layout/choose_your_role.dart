import 'package:booking/bloc/cubit.dart';
import 'package:booking/components/theme.dart';
import 'package:flutter/material.dart';

class ChooseRole extends StatelessWidget {
  const ChooseRole({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Are you a ... ?',
          style: TextStyle(
            fontSize: 24,
            color: textColor,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        // User Role
        Row(
          children: const [
            Role(
              index: 1,
              image: 'assets/user.png',
              role: 'User',
            ),
            SizedBox(
              width: 12,
            ),
            //Manager Role
            Role(
              index: 2,
              image: 'assets/manager.png',
              role: 'Manager',
            ),
          ],
        )
      ],
    );
  }
}

class Role extends StatelessWidget {
  const Role({
    super.key,
    required this.image,
    required this.role,
    required this.index,
  });
  final String image;
  final String role;
  final int index;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => AppCubit.get(context).loginPageState(index),
      child: Container(
        width: MediaQuery.of(context).size.width * 5 / 12,
        height: MediaQuery.of(context).size.width * 5 / 12,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(
              flex: 2,
            ),
            Image.asset(
              image,
              width: 88,
            ),
            const Spacer(
              flex: 1,
            ),
            Text(
              role,
              style: const TextStyle(fontSize: 24, color: Colors.black),
            ),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}
