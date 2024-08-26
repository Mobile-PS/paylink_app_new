import '../../../utils/basic_screen_imports.dart';

class LogInformationWidget extends StatelessWidget {
  const LogInformationWidget({
    super.key,
    required this.variable,
    required this.value,
    this.stoke = true,
    this.isStatus = false,
  });

  final String variable, value;
  final bool stoke;
  final bool isStatus;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        verticalSpace(Dimensions.heightSize * 0.7),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.paddingHorizontalSize * 0.5),
          child: Row(
            mainAxisAlignment: mainSpaceBet,
            children: [
              Expanded(
                flex: 5,
                child: TitleHeading4Widget(
                  maxLines: 1,
                  textOverflow: TextOverflow.ellipsis,
                  text: variable,
                  fontSize: Dimensions.headingTextSize5,
                  fontWeight: FontWeight.w600,
                  color: CustomColor.primaryLightTextColor.withOpacity(0.6),
                ),
              ),
              Visibility(
                visible: !isStatus,
                child: TitleHeading4Widget(
                  maxLines: 1,
                  textOverflow: TextOverflow.ellipsis,
                  text: value,
                  fontSize: Dimensions.headingTextSize3,
                  fontWeight: FontWeight.w700,
                  color: CustomColor.primaryLightTextColor.withOpacity(0.6),
                ),
              ),
              Visibility(
                visible: isStatus,
                child:
                statusInfo(),
              ),
            ],
          ),
        ),
        verticalSpace(Dimensions.heightSize * 0.89),
        Visibility(
          visible: stoke,
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: CustomColor.transparentColor,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingHorizontalSize * 0.5),
              child: const DottedDivider(),
            ),
          ),
        )
      ],
    );
  }
  statusInfo() {
    switch (value) {
      case 'Pending':
        return _customStatusWidget(color: CustomColor.orangeColor);
      case 'Rejected':
        return _customStatusWidget(color: CustomColor.redColor);
      case 'Success':
        return _customStatusWidget(color: CustomColor.greenColor);
      default:
        return _customStatusWidget(color: CustomColor.redColor);
    }
  }

  _customStatusWidget({required Color color}) {
    return
    Container(
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingHorizontalSize * 0.2,
          vertical: Dimensions.paddingVerticalSize * 0.1),
decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radius * 0.3),
        color: color.withOpacity(.2),

),

      child: Center(
        child: TitleHeading4Widget(
          maxLines: 1,
          textOverflow: TextOverflow.ellipsis,
          text: value,
          fontSize: Dimensions.headingTextSize5,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

}




class DottedDivider extends StatelessWidget {
  const DottedDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashedBorderPainter(
        color: Colors.grey, // Set the color of the dotted border
        strokeWidth: 1.0, // Set the width of the dotted border
      ),
    );
  }
}

class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    const double dashWidth = 3; // Adjust the width of the dashes
    const double dashSpace = 2; // Adjust the space between the dashes
    const double startY = 0;

    double currentX = 0;
    while (currentX < size.width) {
      canvas.drawLine(
        Offset(currentX, startY),
        Offset(currentX + dashWidth, startY),
        paint,
      );
      currentX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}