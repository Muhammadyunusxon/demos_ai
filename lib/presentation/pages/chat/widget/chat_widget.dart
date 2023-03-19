import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../infrastructure/services/assets_manager.dart';
import '../../../utils/style/style.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget(
      {super.key,
      required this.msg,
      required this.chatIndex,
      this.shouldAnimate = false});

  final String msg;
  final int chatIndex;
  final bool shouldAnimate;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle =
        Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 19.sp);
    return Column(
      children: [
        Material(
          color:
              chatIndex == 0 ? Theme.of(context).primaryColor : Style.cardColor,
          child: Padding(
            padding: EdgeInsets.all(8.0.r),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  chatIndex == 0
                      ? AssetsManager.userImage
                      : AssetsManager.botImage,
                  height: 30,
                  width: 30,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: chatIndex == 0
                      ? Text(
                          msg,
                          style: textStyle,
                        )
                      : shouldAnimate
                          ? DefaultTextStyle(
                              style: textStyle,
                              child: AnimatedTextKit(
                                  isRepeatingAnimation: false,
                                  repeatForever: false,
                                  displayFullTextOnTap: true,
                                  totalRepeatCount: 1,
                                  animatedTexts: [
                                    TyperAnimatedText(msg.trim(),
                                        textStyle: textStyle),
                                  ]),
                            )
                          : Text(
                              msg.trim(),
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
