import 'package:booking/bloc/cubit.dart';
import 'package:booking/drawer/widgets/drawer_item.dart';
import 'package:flutter/material.dart';

class MainPages extends StatefulWidget {
  const MainPages({super.key, required this.isManager});
  final bool isManager;

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
                body: Column(
                  children: [
                    DrawerItem(
                      isSelected: AppCubit.get(context).mainPagesIndex == 0
                          ? true
                          : false,
                      onTap: () {
                        AppCubit.get(context).navigateToMainPages(context, 0);
                      },
                      text: 'Booking',
                      icon: Icons.calendar_month,
                    ),
                    DrawerItem(
                      isSelected: AppCubit.get(context).mainPagesIndex == 1
                          ? true
                          : false,
                      onTap: () {
                        AppCubit.get(context).navigateToMainPages(context, 1);
                      },
                      text: 'Offers',
                      icon: Icons.local_offer,
                    ),
                    DrawerItem(
                      isSelected: AppCubit.get(context).mainPagesIndex == 2 ||
                              AppCubit.get(context).mainPagesIndex == 4
                          ? true
                          : false,
                      onTap: () async {
                        if (widget.isManager) {
                          AppCubit.get(context).navigateToMainPages(context, 2);
                        } else {
                          AppCubit.get(context).navigateToMainPages(context, 4);
                        }
                      },
                      text: widget.isManager ? 'Chats' : 'Chat',
                      icon: Icons.chat,
                    ),
                    DrawerItem(
                      isSelected: AppCubit.get(context).mainPagesIndex == 3
                          ? true
                          : false,
                      onTap: () {
                        AppCubit.get(context).navigateToMainPages(context, 3);
                      },
                      text: 'Contact Us',
                      icon: Icons.info,
                    ),
                  ],
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