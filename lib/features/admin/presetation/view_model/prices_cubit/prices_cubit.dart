import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:padel_club/core/utilities/services/service_locator.dart';

part 'prices_state.dart';

class PricesCubit extends Cubit<PricesState> {
  PricesCubit() : super(PricesInitial());

  static PricesCubit get(context) => BlocProvider.of(context);

  final TextEditingController dayPriceController = TextEditingController();
  final TextEditingController nightPriceController = TextEditingController();
  final TextEditingController from = TextEditingController();
  final TextEditingController to = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void changePrices(BuildContext context) {
    GetInstance.adminRepoImpl.changePrices(context);
  }
}
