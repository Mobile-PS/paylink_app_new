import '../../../../utils/basic_screen_imports.dart';
import '../../../../utils/responsive_layout.dart';
import '../../../../views/auth/sign_in/sign_in_screen/sign_in_screen_mobile.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  ResponsiveLayout(
      mobileScaffold: SignInScreenMobile(),
    );
  }
}