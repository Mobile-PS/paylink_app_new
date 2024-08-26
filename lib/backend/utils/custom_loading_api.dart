import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../utils/basic_screen_imports.dart';

class CustomLoadingAPI extends StatelessWidget {
  const CustomLoadingAPI({
    super.key,
    this.color,
  });
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitWaveSpinner(
        waveColor: CustomColor.primaryLightColor,
        color: color ?? Theme.of(context).primaryColor,
      ),
    );
  }
}