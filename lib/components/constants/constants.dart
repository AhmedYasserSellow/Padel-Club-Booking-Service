import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

int finalYear = DateTime.now().year + 1;

String pending = 'Pending';
String booked = 'Booked';
String academy = 'Academy';

//Shared Preferences variables
String isLoggedIn = 'isLoggedin';
String yourName = 'Name';
String yourPhone = 'Phone';
String dev = 'dev';
String id = 'ID';
String isOnBoarding = 'isOnBoarding';
String isPremessionShowed = 'isPremessionShowed';

//Lists
List<String> clock = [
  '12:00 AM',
  '1:00 AM',
  '2:00 AM',
  '3:00 AM',
  '4:00 AM',
  '5:00 AM',
  '6:00 AM',
  '7:00 AM',
  '8:00 AM',
  '9:00 AM',
  '10:00 AM',
  '11:00 AM',
  '12:00 PM',
  '1:00 PM',
  '2:00 PM',
  '3:00 PM',
  '4:00 PM',
  '5:00 PM',
  '6:00 PM',
  '7:00 PM',
  '8:00 PM',
  '9:00 PM',
  '10:00 PM',
  '11:00 PM',
];
List<String> abc = [
  'a',
  'b',
  'c',
  'd',
  'e',
  'f',
  'g',
  'h',
  'i',
  'j',
  'k',
  'l',
  'm',
  'm',
  'o',
  'p',
  'q',
  'r',
  's',
  't',
  'u',
  'v',
  'w',
  'x',
  'y',
  'z',
];
List<String> days = [
  'Saturday',
  'Sunday',
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
];

final connection = InternetConnectionCheckerPlus.createInstance(
  checkInterval: const Duration(milliseconds: 500),
  checkTimeout: const Duration(milliseconds: 500),
);
