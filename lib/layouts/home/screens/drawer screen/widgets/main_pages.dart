import 'package:booking/core/utilities/routes/app_routes.dart';
import 'package:booking/layouts/home/logic/home_cubit.dart';
import 'package:booking/layouts/home/screens/drawer%20screen/widgets/drawer_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPages extends StatelessWidget {
  const MainPages({
    super.key,
    required this.isManager,
    required this.myName,
    required this.firebaseID,
  });
  final bool isManager;
  final String myName;
  final String firebaseID;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ExpansionPanelList(
                materialGapSize: 0,
                expandedHeaderPadding: EdgeInsets.zero,
                expansionCallback: (panelIndex, expanded) =>
                    HomeCubit.get(context).pagesExpnasionChanger(expanded),
                elevation: 0,
                children: [
                  ExpansionPanel(
                    canTapOnHeader: true,
                    backgroundColor: Colors.transparent,
                    isExpanded: HomeCubit.get(context).isExpanded,
                    body: ListView.builder(
                      itemCount: homePages(
                        manager: isManager,
                        firebaseID: firebaseID,
                        myName: myName,
                      ).length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return DrawerItem(
                          text: homePages(
                            manager: isManager,
                            firebaseID: firebaseID,
                            myName: myName,
                          )[index]
                              .name,
                          icon: homePages(
                            manager: isManager,
                            firebaseID: firebaseID,
                            myName: myName,
                          )[index]
                              .icon,
                          onTap: () {
                            HomeCubit.get(context)
                                .navigateToMainPages(context, index);
                          },
                          isSelected:
                              HomeCubit.get(context).mainPagesIndex == index,
                        );
                      },
                    ),
                    headerBuilder: (context, isExpanded) {
                      return const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text(
                          'Pages',
                          style: TextStyle(fontSize: 20),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Divider(
                color: HomeCubit.get(context).iconAndTextColor,
              ),
            )
          ],
        );
      },
    );
  }
}
