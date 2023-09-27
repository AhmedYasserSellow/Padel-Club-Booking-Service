import 'package:booking/components/routes/app_routes.dart';
import 'package:booking/layouts/admin/dashboard%20drawer/widgets/dashboard_drawer_item.dart';
import 'package:booking/logic/cubit.dart';
import 'package:booking/components/theme/theme.dart';
import 'package:flutter/material.dart';

class DashboardPages extends StatefulWidget {
  const DashboardPages({super.key});

  @override
  State<DashboardPages> createState() => _DashboardPagesState();
}

class _DashboardPagesState extends State<DashboardPages> {
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
                  itemCount: dashboardPages.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return DashBoardDrawerItem(
                      text: dashboardPages[index].name,
                      icon: dashboardPages[index].icon,
                      onTap: () {
                        AppCubit.get(context)
                            .navigateToDashboardPages(context, index);
                      },
                      isSelected:
                          AppCubit.get(context).dashboardPagesIndex == index,
                    );
                  },
                ),
                headerBuilder: (context, isExpanded) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      'Pages',
                      style: TextStyle(fontSize: 20, color: whiteTextColor),
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
            color: whiteTextColor,
          ),
        )
      ],
    );
  }
}
