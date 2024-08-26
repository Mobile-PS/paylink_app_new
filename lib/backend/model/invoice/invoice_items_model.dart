import '../../../utils/basic_screen_imports.dart';

class InvoiceItemModel {
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  InvoiceItemModel({String title = '', double price = 100.0, int quantity = 1}) {
    titleController.text = title;
    priceController.text = price.toString();
    quantityController.text = quantity.toString();
  }
}