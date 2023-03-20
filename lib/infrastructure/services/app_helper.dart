import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:demos_ai/presentation/utils/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppHelpers {
  AppHelpers._();

  static showConfirm(
      {required BuildContext context,
      required VoidCallback onSummit,
      required String title}) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Confirm',
          style:
              Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 20),
        ),
        content: Text(
          title,
          style:
              Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 18),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'No',
                style: Theme.of(context).textTheme.displayMedium,
              )),
          TextButton(
            onPressed: () {
              onSummit();
              Navigator.pop(context);
            },
            child: Text(
              'Yes',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
        ],
      ),
    );
  }

  static showMyBottomSheet(
      {required BuildContext context,
      required String msg,
      required bool isLoading}) {
    return showBottomSheet(
        backgroundColor: Style.transparent,
        context: context,
        builder: (_) => Container(
              height: MediaQuery.of(context).size.height / 2.2,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
              ),
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                      color: Theme.of(context).secondaryHeaderColor,
                    ))
                  : SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.w, vertical: 12.h),
                      child: DefaultTextStyle(
                        style: Theme.of(context).textTheme.displaySmall!,
                        child: AnimatedTextKit(
                            isRepeatingAnimation: false,
                            repeatForever: false,
                            displayFullTextOnTap: true,
                            totalRepeatCount: 1,
                            animatedTexts: [
                              TyperAnimatedText(msg.trim(),
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .displaySmall!),
                            ]),
                      ),
                    ),
            ));
  }
}
