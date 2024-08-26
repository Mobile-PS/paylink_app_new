import '../../../../utils/basic_screen_imports.dart';
import '../../../../utils/responsive_layout.dart';
import '../../../../views/congratulation/congratulation_screen_mobile.dart';

class CongratulationScreen extends StatelessWidget {
  const CongratulationScreen(
      {super.key,
      required this.subTitle,
      required this.route,
      required this.title, required this.onWillPop});

  final String title, subTitle, route;
  final Future<bool> Function() onWillPop;

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: CongratulationScreenMobile(
        subTitle: subTitle,
        route: route,
        title: title, onWillPop: onWillPop,
      ),
    );
  }
}