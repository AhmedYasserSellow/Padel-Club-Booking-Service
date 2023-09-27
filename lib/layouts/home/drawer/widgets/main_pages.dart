import 'package:booking/core/routes/app_routes.dart';
import 'package:booking/core/theme/logic/theme_cubit.dart';
import 'package:booking/layouts/home/logic/home_cubit.dart';
import 'package:booking/layouts/home/drawer/widgets/drawer_item.dart';
import 'package:flutter/material.dart';

class MainPages extends StatefulWidget {
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
  State<MainPages> createState() => _MainPagesState();
}

class _MainPagesState extends State<MainPages> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ExpansionPanelList(
            materialGapSize: 0,
            expandedHeaderPadding: EdgeInsets.zero,
            expansionCallback: (panelIndex, expanded) => setState(() {
              HomeCubit.get(context).isExpanded = expanded;
            }),
            elevation: 0,
            children: [
              ExpansionPanel(
                canTapOnHeader: true,
                backgroundColor: Colors.transparent,
                isExpanded: HomeCubit.get(context).isExpanded,
                body: ListView.builder(
                  itemCount: appPages(
                    manager: widget.isManager,
                    firebaseID: widget.firebaseID,
                    myName: widget.myName,
                  ).length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return DrawerItem(
                      text: appPages(
                        manager: widget.isManager,
                        firebaseID: widget.firebaseID,
                        myName: widget.myName,
                      )[index]
                          .name,
                      icon: appPages(
                        manager: widget.isManager,
                        firebaseID: widget.firebaseID,
                        myName: widget.myName,
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
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
            color: ThemeCubit.get(context).iconAndTextColor,
          ),
        )
      ],
    );
  }
}
