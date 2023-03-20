import 'package:flutter/material.dart';

import '../../../utils/style/style.dart';

class MyFormFiled extends StatelessWidget {
  final TextEditingController? controller;
  final String title;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final Color? titleColor;
  final Color? fillColor;
  final Color? borderColor;
  final Widget? suffix;
  final Widget? prefix;
  final Widget? suffixIcon;
  final ValueChanged? onChange;
  final bool formatter;

  const MyFormFiled(
      {Key? key,
      this.controller,
      required this.title,
      this.textInputAction = TextInputAction.done,
      this.textInputType = TextInputType.text,
      this.titleColor,
      this.fillColor,
      this.suffix,
      this.prefix,
      this.borderColor,
      this.suffixIcon,
      this.onChange,
      this.formatter = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChange,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      controller: controller,
      style: Theme.of(context).textTheme.displaySmall,
      decoration: Style.myDecoration(
          title: title,
          titleColor: titleColor,
          fillColor: fillColor,
          suffixIcon: suffix,
          borderColor: borderColor,
          prefixIcon: prefix),
    );
  }
}
