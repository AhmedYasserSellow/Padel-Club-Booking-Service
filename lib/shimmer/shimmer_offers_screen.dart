import 'package:booking/shimmer/shimmer_item.dart';
import 'package:flutter/material.dart';

class OffersShimmer extends StatelessWidget {
  const OffersShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          const ShimmerItem(
            height: 32,
            width: 100,
          ),
          const SizedBox(
            height: 12,
          ),
          ShimmerItem(height: MediaQuery.of(context).size.width - 32)
        ],
      ),
    );
  }
}
