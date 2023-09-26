import 'package:booking/shimmer/shimmer_item.dart';
import 'package:flutter/material.dart';

class BookingShimmer extends StatelessWidget {
  const BookingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const ShimmerItem(
              height: 24,
            ),
            const SizedBox(
              height: 8,
            ),
            const ShimmerItem(
              height: 250,
            ),
            const SizedBox(
              height: 8,
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => const ShimmerItem(height: 40),
              separatorBuilder: (context, index) => const SizedBox(
                height: 8,
              ),
              itemCount: 24,
            )
          ],
        ),
      ),
    );
  }
}
