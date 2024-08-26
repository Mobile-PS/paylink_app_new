import '../../../../../utils/basic_screen_imports.dart';
import '../../../../../utils/responsive_layout.dart';
import '../../../../../views/dashboard/drawer_menu_items/notifications/notifications_screen_mobile.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: NotificationsScreenMobile(),
    );
  }
}