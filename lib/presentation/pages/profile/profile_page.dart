import 'package:demos_ai/application/app_cubit/app_cubit.dart';
import 'package:demos_ai/infrastructure/services/app_helper.dart';
import 'package:demos_ai/presentation/pages/profile/widgets/limit_widget.dart';
import 'package:demos_ai/presentation/pages/profile/widgets/setting_widget.dart';
import 'package:demos_ai/presentation/utils/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../application/home_cubit/home_cubit.dart';
import '../../../infrastructure/services/local_storage.dart';
import '../../app_router.dart';
import '../../utils/components/my_image_network.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                24.h.verticalSpace,
                BlocBuilder<HomeCubit, HomeState>(
                  buildWhen: (p, s) => p.user != s.user,
                  builder: (context, state) {
                    return Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: Theme.of(context).secondaryHeaderColor,
                                  size: 20,
                                )),
                            const Spacer(),
                            Padding(
                              padding: EdgeInsets.only(top: 32.h),
                              child: Container(
                                padding: EdgeInsets.all(7.r),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Theme.of(context).cardColor, width: 2.r),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: CustomImageNetwork(
                                    radius: 100,
                                    height: 120.r,
                                    width: 120.r,
                                    image: state.user?.avatar),
                              ),
                            ),
                            const Spacer(flex: 2,),

                          ],
                        ),
                        24.h.verticalSpace,
                        Text(
                          (state.user?.name?.contains(" ") == true
                                  ? state.user?.name?.substring(
                                      0, state.user?.name?.indexOf(" "))
                                  : state.user?.name) ??
                              "",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(fontSize: 22.sp),
                        ),
                        2.h.verticalSpace,
                        Text(
                          (state.user?.name?.contains(" ") == true
                                  ? state.user?.name?.substring(
                                      state.user?.name?.indexOf(" ") ?? 0)
                                  : " ") ??
                              "",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontSize: 20.sp),
                        ),
                        12.h.verticalSpace,
                        Text(
                          "Joined ${DateFormat.yMMMd().format(DateTime.parse(state.user?.joinTime ?? "${DateTime.now()}"))}",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontSize: 16.sp),
                        ),
                        42.h.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            LimitWidget(
                              title: "Daily limit",
                              value: state.user?.dailyLimit.toString() ?? "0",
                              color: Style.secondaryColor,
                            ),
                            LimitWidget(
                              title: "Extra limit",
                              value: state.user?.extraLimit.toString() ?? "0",
                              color: Style.indigoColor,
                            )
                          ],
                        ),
                      ],
                    );
                  },
                ),
                44.h.verticalSpace,
                BlocBuilder<AppCubit, AppState>(
                  builder: (context, state) {
                    return SettingWidget(
                      title: "Change theme",
                      color: Style.primaryColor,
                      onTap: () {
                        context.read<AppCubit>().change();
                      },
                      icon:
                          state.isChangeTheme ? Icons.sunny : Icons.nightlight,
                    );
                  },
                ),
                24.h.verticalSpace,
                SettingWidget(
                  title: "Add Limit",
                  color: Style.infoColor,
                  onTap: () {},
                  icon: Icons.add,
                ),
                24.h.verticalSpace,
                SettingWidget(
                  title: "Log Out",
                  color: Style.errorColor,
                  onTap: () {
                    AppHelpers.showConfirm(
                        context: context,
                        onSummit: () {
                          LocalStore.removeDocId();
                          Navigator.pushAndRemoveUntil(
                              context, Routes.goSplash(), (route) => false);
                        },
                        title: "Do you want to log out?");
                  },
                  icon: Icons.logout,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
