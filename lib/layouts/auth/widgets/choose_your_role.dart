import 'package:booking/logic/cubit.dart';
import 'package:booking/core/theme/theme.dart';
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
            color: whiteTextColor,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        // User Role
        const Row(
          children: [
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
              image: 'assets/manager_light_mode.png',
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
          color: const Color.fromRGBO(255, 255, 255, 1),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(
              flex: 2,
            ),
            Image.asset(
              image,
              width: MediaQuery.of(context).size.width / 4,
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
