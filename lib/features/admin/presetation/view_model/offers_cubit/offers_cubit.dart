import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:padel_club/core/utilities/services/service_locator.dart';

part 'offers_state.dart';

class OffersCubit extends Cubit<OffersState> {
  OffersCubit() : super(OffersInitial());

  static OffersCubit get(context) => BlocProvider.of(context);

  final TextEditingController offerTitleController = TextEditingController();
  final TextEditingController offerControllerImage = TextEditingController();
  final TextEditingController offerControllerLinkForFacebook =
      TextEditingController();
  final TextEditingController offerControllerLinkForInstagram =
      TextEditingController();
  final TextEditingController offerIDController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void addOffers(BuildContext context) {
    GetInstance.adminRepoImpl.addOffers(context);
  }
}
