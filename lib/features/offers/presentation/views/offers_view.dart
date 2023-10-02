import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:padel_club/features/home/presentation/view_models/home_cubit/home_cubit.dart';

import 'package:padel_club/features/offers/presentation/views/widgets/offers_list_builder.dart';

class OffersView extends StatelessWidget {
  const OffersView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      return const OffersListBuilder();
    });
  }
}
