import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:barcode_widget/barcode_widget.dart';

class BarcodeGenerateWidget extends StatelessWidget {

  const BarcodeGenerateWidget({super.key, required this.qrText});
  final String qrText;

  @override
  Widget build(BuildContext context) {
    return BarcodeWidget(
      barcode: Barcode.qrCode(
        errorCorrectLevel: BarcodeQRCorrectionLevel.high,
      ),
      data: qrText,
    );
  }
}