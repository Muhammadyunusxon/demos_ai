import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingWidget extends StatelessWidget {
  final String title;
  final Color color;
  final VoidCallback onTap;
  final IconData icon;

  const SettingWidget(
      {Key? key,
      required this.title,
      required this.color,
      required this.onTap,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 21.h, horizontal: 28.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.r),
          color: color.withOpacity(0.1),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: color,
              size: 21,
            ),
            12.horizontalSpace,
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(fontSize: 15.6, color: color),
            ),
            const Spacer(),
            Icon(Icons.arrow_forward_ios, color: color, size: 18),
          ],
        ),
      ),
    );
  }
}
