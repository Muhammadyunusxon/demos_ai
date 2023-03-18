import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/style/blur.dart';
import '../../../utils/style/style.dart';

class HomeButtons extends StatelessWidget {
  final String svgName;
  final String title;
  const HomeButtons({Key? key, required this.svgName, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 150,
      width: MediaQuery.of(context).size.width/2.2,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Style.secondaryColor),
      child: FrostedGlassBox(
        sigmaXY: 6,
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24.h),
          child: Column(
            children: [
              SvgPicture.asset(
                "assets/svg/$svgName.svg",
                height: 33,
                color: Theme.of(context).secondaryHeaderColor,
              ),
              7.verticalSpace,
              Text(
                title,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
