import '../../../../views/onboard_screen/onboard_screen_mobile.dart';
import '../../utils/basic_screen_imports.dart';
import '../../utils/responsive_layout.dart';

class OnboardScreen extends StatelessWidget {
  const OnboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: OnboardScreenMobile(),
    );
  }
}