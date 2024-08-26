import '../../../utils/basic_screen_imports.dart';

class StatusDataWidget extends StatelessWidget {
  const StatusDataWidget({super.key, required this.text, required this.icon});

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(vertical: Dimensions.paddingVerticalSize),
        margin: EdgeInsets.symmetric(horizontal: Dimensions.paddingHorizontalSize),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: CustomColor.blackColor.withOpacity(0.4),
                size: Dimensions.iconSizeLarge * 1.5,
              ),
              verticalSpace(Dimensions.paddingVerticalSize * 0.3),
              TitleHeading1Widget(
                text: text,
                color: CustomColor.blackColor.withOpacity(0.4),
                textAlign: TextAlign.center,
                fontSize: Dimensions.headingTextSize3,
              )
            ],
          ),
        ),
      ),
    );
  }
}