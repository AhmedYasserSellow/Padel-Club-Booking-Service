import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:padel_club/core/utilities/constants/constants.dart';
import 'package:padel_club/core/utilities/services/notifications.dart';
import 'package:padel_club/core/utilities/services/service_locator.dart';
import 'package:padel_club/core/utilities/theme/theme.dart';
import 'package:padel_club/features/home/data/models/booking_service_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(AppIntialState());

  static HomeCubit get(context) => BlocProvider.of(context);
  int mainPagesIndex = 0;
  bool isExpanded = false;
  DateTime focusedDay = DateTime.now();
  DateTime today = DateTime.now();
  int finalYear = DateTime.now().year + 1;

  bool manager = false;
  String name = '';
  String phone = '';
  String firebaseID = '';
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Future loadState() async {
    NotificationService.enableFirebaseMessaging();
    final prefs = await GetInstance.prefs;
    manager = prefs.getBool(PrefsKeys.kAdmin)!;
    name = prefs.getString(PrefsKeys.kName)!;
    phone = prefs.getString(PrefsKeys.kPhone)!;
    firebaseID = prefs.getString(PrefsKeys.kFirebaseID)!;
  }

//Navigate in Drawer for home layout
  void navigateToMainPages(BuildContext context, int index,
      {bool isDrawer = true}) {
    mainPagesIndex = index;
    if (isDrawer) {
      scaffoldKey.currentState!.closeDrawer();
    } else {
      Navigator.pop(context);
    }

    emit(NavigateToAnotherMainPage());
  }

//Change Expansion
  void pagesExpnasionChanger(bool expanded) {
    isExpanded = expanded;
    emit(ChangeExpansion());
  }

//Change selected day

  void changeSelectedDay(DateTime day) {
    focusedDay = day;
    emit(DayChanged());
  }

//Profile Name Changer
  void changeName() async {
    emit(NameChanged());
  }

  Brightness brightness = Brightness.light;
  Color iconAndTextColor = Colors.black;
  IconData modeIcon = Icons.light_mode;
  bool isLightMode = true;
  int loginFormState = 0;
  bool firstLogin = true;

// Get Theme
  Future<bool> getTheme() async {
    final prefs = await GetInstance.prefs;

    bool isLightMode;
    if (prefs.getBool('Mode') == null) {
      prefs.setBool('Mode', true);
    }
    isLightMode = prefs.getBool('Mode')!;
    return isLightMode;
  }

  void getAppTheme() async {
    isLightMode = await getTheme();
    if (isLightMode) {
      iconAndTextColor = AppTheme.textAndIconLightCoLor;
      modeIcon = Icons.light_mode;
    } else {
      iconAndTextColor = AppTheme.textAndIconDarkColor;
      modeIcon = Icons.dark_mode;
    }
    emit(GetTheme());
  }

//Change Theme
  void changeTheme() async {
    final prefs = await GetInstance.prefs;
    if (isLightMode) {
      isLightMode = !isLightMode;
      prefs.setBool('Mode', isLightMode);
      brightness = Brightness.dark;
      iconAndTextColor = AppTheme.textAndIconDarkColor;
      modeIcon = Icons.dark_mode;
    } else {
      isLightMode = !isLightMode;
      prefs.setBool('Mode', isLightMode);
      brightness = Brightness.light;
      iconAndTextColor = AppTheme.textAndIconLightCoLor;
      modeIcon = Icons.light_mode;
    }
    emit(ChangeTheme());
  }

  Future logOut(BuildContext context) async {
    GetInstance.homeRepoImpl.logOut(context);
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  Future confirmBooking(
      BuildContext context, BookingServiceModel bookingServiceModel) async {
    GetInstance.homeRepoImpl.confirmBooking(context, bookingServiceModel);
  }

  Future cancelBooking(
      BuildContext context, BookingServiceModel bookingServiceModel) async {
    GetInstance.homeRepoImpl.cancelBooking(context, bookingServiceModel);
  }

  Future addBooking(BuildContext context,
      BookingServiceModel bookingServiceModel, bool manager, myID) async {
    GetInstance.homeRepoImpl.addNewBook(context, bookingServiceModel, manager,
        nameController, phoneNumberController, myID);
  }

  TextEditingController profileNameController = TextEditingController();
  TextEditingController profilePhoneController = TextEditingController();

  Future updateProfile(
    BuildContext context,
  ) async {
    GetInstance.homeRepoImpl
        .updateProfile(context, profileNameController, profilePhoneController);
  }
}
