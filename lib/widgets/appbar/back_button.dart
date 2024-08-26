import '../../utils/basic_widget_imports.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    bool isTablet() {
      return MediaQuery.of(context).size.shortestSide >= 600;
    }

    return IconButton(
      padding: EdgeInsets.symmetric(
          horizontal: isTablet()
              ? Dimensions.paddingHorizontalSize * .25
              : Dimensions.paddingHorizontalSize * .5),
      onPressed: onTap,
      icon: CircleAvatar(
        radius: isTablet() ? Dimensions.radius * 10 : Dimensions.radius * 1.2,
        backgroundColor: CustomColor.primaryLightColor,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.paddingHorizontalSize * .3),
          child: Icon(
            Icons.arrow_back_ios,
            color: CustomColor.whiteColor,
            size: Dimensions.heightSize,
            weight: Dimensions.widthSize * 2,
          ),
        ),
      ),
    );
  }
}