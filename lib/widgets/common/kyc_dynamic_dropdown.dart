import '../../utils/basic_screen_imports.dart';

class KycDynamicDropDown extends StatelessWidget {
  final RxString selectMethod;
  final List<String> itemsList;
  final void Function(String?)? onChanged;

  const KycDynamicDropDown({
    required this.itemsList,
    super.key,
    required this.selectMethod,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          height: Dimensions.inputBoxHeight * .75,
          decoration: BoxDecoration(
            border: Border.all(
              color: CustomColor.primaryLightTextColor.withOpacity(0.1),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
          ),
          child: DropdownButtonHideUnderline(
            child: Padding(
              padding: const EdgeInsets.only(left: 5, right: 20),
              child: DropdownButton(
                dropdownColor: Theme.of(context).primaryColor,
                hint: Padding(
                  padding: EdgeInsets.only(
                      left: Dimensions.paddingHorizontalSize * 0.7),
                  child: Text(
                    selectMethod.value,
                    style: CustomStyle.darkHeading3TextStyle.copyWith(
                      color: CustomColor.primaryLightTextColor,
                    ),
                  ),
                ),
                icon: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingHorizontalSize * .1),
                  child: const Icon(
                    Icons.arrow_drop_down,
                    color: CustomColor.primaryLightTextColor,
                  ),
                ),
                isExpanded: true,
                underline: Container(),
                borderRadius: BorderRadius.circular(Dimensions.radius),
                items: itemsList.map<DropdownMenuItem<String>>((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value.toString(),
                      style: CustomStyle.lightHeading3TextStyle.copyWith(
                        color: CustomColor.whiteColor,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ));
  }
}