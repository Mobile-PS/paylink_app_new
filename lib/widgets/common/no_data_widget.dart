import '../../utils/basic_widget_imports.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key, required this.text});
final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingHorizontalSize * .5,
          vertical: Dimensions.paddingVerticalSize * .25),
      child: Card(
        elevation: 3,
        child: Center(
          child: TitleHeading1Widget(
            text: text,
            color: CustomColor.primaryLightColor,
          ),
        ),
      ),
    );
  }
}