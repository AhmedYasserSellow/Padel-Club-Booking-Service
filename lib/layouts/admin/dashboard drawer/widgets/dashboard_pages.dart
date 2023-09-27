import 'package:booking/layouts/admin/dashboard%20drawer/widgets/dashboard_drawer_item.dart';
import 'package:booking/layouts/admin/screens/academy.dart';
import 'package:booking/layouts/admin/screens/offers.dart';
import 'package:booking/layouts/admin/screens/pin_times.dart';
import 'package:booking/layouts/admin/screens/prices.dart';
import 'package:booking/layouts/admin/screens/years.dart';
import 'package:booking/logic/cubit.dart';
import 'package:booking/components/models/page_model.dart';
import 'package:booking/components/theme.dart';
import 'package:flutter/material.dart';

List<PageModel> screens = [
  PageModel(
    icon: Icons.pin_drop,
    name: 'Pin',
    mainWidget: PinTimes(),
  ),
  PageModel(
    icon: Icons.sports_tennis,
    name: 'Academy',
    mainWidget: ControlAcademy(),
  ),
  PageModel(
    icon: Icons.local_offer,
    name: 'Offers',
    mainWidget: ControlOffers(),
  ),
  PageModel(
    icon: Icons.calendar_month,
    name: 'Database Years',
    mainWidget: AddYearsToDB(),
  ),
  PageModel(
    icon: Icons.price_change,
    name: 'Prices',
    mainWidget: PricesScreen(),
  )
];

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
                  itemCount: screens.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return DashBoardDrawerItem(
                      text: screens[index].name,
                      icon: screens[index].icon,
                      onTap: () {
                        AppCubit.get(context)
                            .navigateToDashboardPages(context, index);
                      },
                      isSelected:
                          AppCubit.get(context).dashboardPAgesIndex == index,
                    );
                  },
                ),
                headerBuilder: (context, isExpanded) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      'Pages',
                      style: TextStyle(fontSize: 20, color: textColor),
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
