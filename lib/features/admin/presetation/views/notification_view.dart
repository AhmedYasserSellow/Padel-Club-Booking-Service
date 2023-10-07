import 'package:flutter/material.dart';
import 'package:padel_club/core/utilities/services/service_locator.dart';
import 'package:padel_club/core/utilities/theme/theme.dart';
import 'package:padel_club/core/widgets/loading_indicator.dart';
import 'package:padel_club/features/admin/presetation/views/widgets/notification_list_tile.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: GetInstance.store.collection('Notifications').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text(
                  'There is no Notifications',
                  style: TextStyle(
                    color: AppTheme.whiteTextColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                ),
              );
            } else {
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 20,
                  );
                },
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return NotificationListTile(
                    snapshot: snapshot,
                    index: index,
                  );
                },
              );
            }
          } else {
            return const Center(
              child: LoadingIndicator(),
            );
          }
        });
  }
}
