import 'package:booking/components/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cubit.dart';
import '../bloc/states.dart';
import 'db.dart';

List screens = [
  PinTimes(),
  ControlAcademy(),
  AddYearsToDB(),
];

class ControlPanel extends StatelessWidget {
  const ControlPanel({super.key});
  static String id = 'CMD';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: BackButton(
              color: AppCubit.get(context).iconAndTextColor,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              'Control Panel',
              style: TextStyle(color: AppCubit.get(context).iconAndTextColor),
            ),
            centerTitle: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            actions: [
              IconButton(
                onPressed: () {
                  AppCubit.get(context).changeTheme();
                },
                icon: Icon(
                  AppCubit.get(context).modeIcon,
                ),
                color: AppCubit.get(context).iconAndTextColor,
              ),
              const SizedBox(
                width: 8,
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              AppCubit.get(context).changeBottomNavIndexForDB(value);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.pin_drop),
                label: 'Pinning',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.sports_tennis),
                label: 'Academy',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.numbers),
                label: 'Years',
              ),
            ],
            showUnselectedLabels: false,
            currentIndex: AppCubit.get(context).navIndexForDB,
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: screens[AppCubit.get(context).navIndexForDB],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ControlAcademy extends StatelessWidget {
  ControlAcademy({super.key});
  final TextEditingController yeasAcademy = TextEditingController();
  final TextEditingController monthAcademy = TextEditingController();
  final TextEditingController fromAcademy = TextEditingController();
  final TextEditingController toAcademy = TextEditingController();
  final TextEditingController dayIndex = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Academy'),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: yeasAcademy,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Year',
                  prefixIcon: Icon(
                    Icons.numbers,
                    color: AppCubit.get(context).iconAndTextColor,
                  ),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Month',
                  prefixIcon: Icon(
                    Icons.numbers,
                    color: AppCubit.get(context).iconAndTextColor,
                  ),
                  border: const OutlineInputBorder(),
                ),
                controller: monthAcademy,
              ),
              const SizedBox(
                height: 12,
              ),
              const Text('Academy Time 24H Format'),
              const SizedBox(
                height: 12,
              ),
              TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'From',
                  prefixIcon: Icon(
                    Icons.numbers,
                    color: AppCubit.get(context).iconAndTextColor,
                  ),
                  border: const OutlineInputBorder(),
                ),
                controller: fromAcademy,
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'To',
                  prefixIcon: Icon(
                    Icons.numbers,
                    color: AppCubit.get(context).iconAndTextColor,
                  ),
                  border: const OutlineInputBorder(),
                ),
                controller: toAcademy,
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Day Number',
                  prefixIcon: Icon(
                    Icons.numbers,
                    color: AppCubit.get(context).iconAndTextColor,
                  ),
                  border: const OutlineInputBorder(),
                ),
                controller: dayIndex,
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('1 : ${days[0]}'),
                  Text('2 : ${days[1]}'),
                  Text('3 : ${days[2]}'),
                  Text('4 : ${days[3]}'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('5 : ${days[4]}'),
                  Text('6 : ${days[5]}'),
                  Text('7 : ${days[6]}'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: availableColor),
                    onPressed: () {
                      addAcdemy(
                          int.tryParse(yeasAcademy.text)!,
                          int.tryParse(monthAcademy.text)!,
                          int.tryParse(fromAcademy.text)!,
                          int.tryParse(toAcademy.text)!,
                          days[int.tryParse(dayIndex.text)! - 1],
                          context);
                    },
                    child: const Text('Add Selected Day'),
                  ),
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: bookedColor),
                    onPressed: () {
                      removeAcdemy(
                          int.tryParse(yeasAcademy.text)!,
                          int.tryParse(monthAcademy.text)!,
                          int.tryParse(fromAcademy.text)!,
                          int.tryParse(toAcademy.text)!,
                          days[int.tryParse(dayIndex.text)! - 1],
                          context);
                    },
                    child: const Text('Remove Selected Day'),
                  ),
                ],
              ),
            ],
          );
        });
  }
}

class AddYearsToDB extends StatelessWidget {
  AddYearsToDB({super.key});
  final TextEditingController yearDBField = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Year'),
              const SizedBox(
                height: 12,
              ),
              TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Year',
                  prefixIcon: Icon(
                    Icons.numbers,
                    color: AppCubit.get(context).iconAndTextColor,
                  ),
                  border: const OutlineInputBorder(),
                ),
                controller: yearDBField,
              ),
              const SizedBox(
                height: 12,
              ),
              ElevatedButton(
                  onPressed: () {
                    createDatabase(yearDBField.text, context);
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 16),
                              const Text('Adding'),
                              Text(
                                  'Month : ${AppCubit.get(context).monthDB}.....'),
                              Text('Day : ${AppCubit.get(context).dayDB}....')
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: const Text('Add to Database')),
            ],
          );
        });
  }
}

class PinTimes extends StatelessWidget {
  PinTimes({super.key});
  final TextEditingController yearsForPin = TextEditingController();
  final TextEditingController monthForPin = TextEditingController();
  final TextEditingController startPin = TextEditingController();
  final TextEditingController endPin = TextEditingController();
  final TextEditingController dayIndex = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('User Info'),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: name,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(
                    Icons.title,
                    color: AppCubit.get(context).iconAndTextColor,
                  ),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: phone,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: Icon(
                    Icons.phone,
                    color: AppCubit.get(context).iconAndTextColor,
                  ),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const Text('Pinning Time'),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: yearsForPin,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Year',
                  prefixIcon: Icon(
                    Icons.numbers,
                    color: AppCubit.get(context).iconAndTextColor,
                  ),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Month',
                  prefixIcon: Icon(
                    Icons.numbers,
                    color: AppCubit.get(context).iconAndTextColor,
                  ),
                  border: const OutlineInputBorder(),
                ),
                controller: monthForPin,
              ),
              const SizedBox(
                height: 12,
              ),
              const Text('Pinning Time 24H Format'),
              const SizedBox(
                height: 12,
              ),
              TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'From',
                  prefixIcon: Icon(
                    Icons.numbers,
                    color: AppCubit.get(context).iconAndTextColor,
                  ),
                  border: const OutlineInputBorder(),
                ),
                controller: startPin,
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'To',
                  prefixIcon: Icon(
                    Icons.numbers,
                    color: AppCubit.get(context).iconAndTextColor,
                  ),
                  border: const OutlineInputBorder(),
                ),
                controller: endPin,
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Day Number',
                  prefixIcon: Icon(
                    Icons.numbers,
                    color: AppCubit.get(context).iconAndTextColor,
                  ),
                  border: const OutlineInputBorder(),
                ),
                controller: dayIndex,
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('1 : ${days[0]}'),
                  Text('2 : ${days[1]}'),
                  Text('3 : ${days[2]}'),
                  Text('4 : ${days[3]}'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('5 : ${days[4]}'),
                  Text('6 : ${days[5]}'),
                  Text('7 : ${days[6]}'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: availableColor),
                    onPressed: () {
                      addPin(
                          int.tryParse(yearsForPin.text)!,
                          int.tryParse(monthForPin.text)!,
                          int.tryParse(startPin.text)!,
                          int.tryParse(endPin.text)!,
                          days[int.tryParse(dayIndex.text)! - 1],
                          name.text,
                          phone.text,
                          context);
                    },
                    child: const Text('Add Pin'),
                  ),
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: bookedColor),
                    onPressed: () {
                      removePin(
                          int.tryParse(yearsForPin.text)!,
                          int.tryParse(monthForPin.text)!,
                          int.tryParse(startPin.text)!,
                          int.tryParse(endPin.text)!,
                          days[int.tryParse(dayIndex.text)! - 1],
                          name.text,
                          phone.text,
                          context);
                    },
                    child: const Text('Remove Pin'),
                  ),
                ],
              ),
            ],
          );
        });
  }
}
