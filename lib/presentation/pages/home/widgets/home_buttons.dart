import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/style/style.dart';

class HomeButtons extends StatelessWidget {
  final String title;
  final Color color;
  final VoidCallback onTap;
  final String svg;

  const HomeButtons(
      {Key? key,
      required this.title,
      required this.color,
      required this.onTap,
        required this.svg})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 22.h, horizontal: 28.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.r),
          color: color,
        ),
        child: Row(
          children: [
            SvgPicture.asset("assets/svg/$svg.svg",color: Theme.of(context).primaryColor,height: 21,),
            12.horizontalSpace,
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(fontSize: 20.5.sp, color: Theme.of(context).primaryColor),
            ),
            const Spacer(),
            Icon(Icons.arrow_forward_ios, color: Theme.of(context).primaryColor, size: 18),
          ],
        ),
      ),
    );
  }
}
