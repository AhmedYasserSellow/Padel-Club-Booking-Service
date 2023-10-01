import 'package:flutter/material.dart';
import 'package:padel_club/features/auth/presentation/view_models/auth_cubit/auth_cubit.dart';

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
      onTap: () => AuthCubit.get(context).loginPageState(index),
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
