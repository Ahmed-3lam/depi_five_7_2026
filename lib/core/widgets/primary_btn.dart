import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../const/colors.dart';

class PrimaryBtn extends StatelessWidget {
  late final Color? backgroundColor;
  late final Color? textColor;
  late final String? text;
  PrimaryBtn._();

  PrimaryBtn.greenBtn(this.text) {
    backgroundColor = MyColors.primaryColor;
    textColor = Colors.white;
  }

  PrimaryBtn.whiteBtn(this.text) {
    backgroundColor = Colors.white;
    textColor = Colors.black;
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 56,
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(text!, style: TextStyle(color: textColor, fontSize: 16)),
      ),
    );
  }
}
