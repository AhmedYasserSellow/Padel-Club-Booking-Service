import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:padel_club/core/utilities/services/service_locator.dart';
import 'package:padel_club/core/utilities/theme/theme.dart';
import 'package:padel_club/features/home/presentation/views/offers_view.dart';

part 'offers_state.dart';

class OffersCubit extends Cubit<OffersState> {
  OffersCubit() : super(OffersInitial());

  static OffersCubit get(context) => BlocProvider.of(context);

  final TextEditingController offerTitleController = TextEditingController();
  final TextEditingController offerControllerImage = TextEditingController();
  final TextEditingController offerControllerLink = TextEditingController();
  final TextEditingController offerIDController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void addOffers(BuildContext context) {
    GetInstance.adminRepoImpl.addOffers(context);
  }

  void openOffersScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.racketFirstColor,
                  AppTheme.racketSecondColor,
                ],
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                leading: BackButton(
                  color: AppTheme.whiteTextColor,
                ),
                title: Text(
                  'Offers',
                  style: TextStyle(
                    color: AppTheme.whiteTextColor,
                  ),
                ),
                centerTitle: true,
                backgroundColor: Colors.transparent,
              ),
              body: const OffersScreen(removeFeature: true),
            ),
          );
        },
      ),
    );
  }
}
