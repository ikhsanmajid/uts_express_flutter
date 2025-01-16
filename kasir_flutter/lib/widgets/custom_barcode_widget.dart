import 'package:barcode_widget/barcode_widget.dart';

class CustomBarcodeWidget {
  final String barcode;

  CustomBarcodeWidget({required this.barcode});

  BarcodeWidget build() {
    return BarcodeWidget(
      barcode: Barcode.code128(),
      data: barcode,
      width: 100,
      height: 100,
    );
  }
}
