import 'package:booking/bloc/cubit.dart';
import 'package:booking/components/constants.dart';
import 'package:booking/drawer/widgets/drawer_item.dart';
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
              AppCubit.get(context).isExpanded = expanded;
            }),
            elevation: 0,
            children: [
              ExpansionPanel(
                canTapOnHeader: true,
                backgroundColor: Colors.transparent,
                isExpanded: AppCubit.get(context).isExpanded,
                body: ListView.builder(
                  itemCount: mainPages(
                    manager: widget.isManager,
                    firebaseID: widget.firebaseID,
                    myName: widget.myName,
                  ).length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return DrawerItem(
                      text: mainPages(
                        manager: widget.isManager,
                        firebaseID: widget.firebaseID,
                        myName: widget.myName,
                      )[index]
                          .name,
                      icon: mainPages(
                        manager: widget.isManager,
                        firebaseID: widget.firebaseID,
                        myName: widget.myName,
                      )[index]
                          .icon,
                      onTap: () {
                        AppCubit.get(context)
                            .navigateToMainPages(context, index);
                      },
                      isSelected: AppCubit.get(context).mainPagesIndex == index,
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
            color: AppCubit.get(context).iconAndTextColor,
          ),
        )
      ],
    );
  }
}
