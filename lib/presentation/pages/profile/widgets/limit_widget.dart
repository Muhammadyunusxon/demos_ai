import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LimitWidget extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  const LimitWidget({Key? key, required this.title, required this.value, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.symmetric(
          vertical: 16.h, horizontal: 18.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.r),
        color: color.withOpacity(0.05),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .displayMedium
                ?.copyWith(fontSize: 21.sp,color: color),
          ),
          6.h.verticalSpace,
          Text(
            value,
            style: Theme.of(context)
                .textTheme
                .displayMedium
                ?.copyWith(fontSize: 26.sp,color: color),
          ),
        ],
      ),
    );
  }
}
