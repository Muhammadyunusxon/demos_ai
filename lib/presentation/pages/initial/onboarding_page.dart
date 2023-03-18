import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../application/app_cubit/app_cubit.dart';
import '../../../infrastructure/models/on_boarding_model.dart';
import '../../../infrastructure/services/local_storage.dart';
import '../../app_router.dart';
import '../../utils/components/my_button.dart';
import '../../utils/style/style.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            children: [
              180.h.verticalSpace,
              BlocBuilder<AppCubit, AppState>(
                buildWhen: (p, s) => p.page != s.page,
                builder: (context, state) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: SizedBox(
                      height: 365.h,
                      child: Image.asset(onBoardingList[state.page].image),
                    ),
                  );
                },
              ),
              48.h.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: BlocBuilder<AppCubit, AppState>(
                  buildWhen: (p, s) => p.page != s.page,
                  builder: (context, state) {
                    return Text(
                      onBoardingList[state.page].title,
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(fontSize: 35.sp),
                      textAlign: TextAlign.center,
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16.h, right: 24.w, left: 24.w),
                child: BlocBuilder<AppCubit, AppState>(
                  buildWhen: (p, s) => p.page != s.page,
                  builder: (context, state) {
                    return Text(
                      onBoardingList[state.page].description,
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    );
                  },
                ),
              ),
              const Spacer(),
              BlocBuilder<AppCubit, AppState>(
                buildWhen: (p, s) => p.page != s.page,
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < 3; i++)
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          margin: EdgeInsets.symmetric(horizontal: 3.w),
                          height: 6,
                          width: state.page == i ? 14 : 6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: state.page == i
                                ? Style.secondaryColor
                                : Theme.of(context).cardColor,
                          ),
                        ),
                    ],
                  );
                },
              ),
              38.h.verticalSpace,
              Padding(
                padding: EdgeInsets.only(left: 24.w, right: 24.w),
                child: MyButton(
                  text: 'Next',
                  onTap: () {
                    context.read<AppCubit>().changePageIndex(onPushed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          Routes.goAuth(), (route) => false);
                      LocalStore.setOnBoarding();
                    });
                  },
                ),
              ),
              72.h.verticalSpace,
            ],
          ),
        ));
  }
}
