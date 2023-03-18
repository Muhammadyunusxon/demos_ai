import 'package:demos_ai/presentation/pages/auth/widgets/social_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../application/auth_cubit/auth_cubit.dart';
import '../../app_router.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              const Spacer(flex: 4),
              Text(
                "Welcome to Demos AI",
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(fontSize: 34.sp),
              ),
              const Spacer(flex: 1),
              SizedBox(
                  width: MediaQuery.of(context).size.width / 2.5,
                  height: 275.h,
                  child: Image.asset("assets/images/logo.png")),
              const Spacer(),
              Text(
                "Get in through",
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(fontSize: 24.sp),
              ),
              const Spacer(flex: 2),
              BlocBuilder<AuthCubit, AuthState>(
                buildWhen: (p, s) => p.isFacebookLoading != s.isFacebookLoading,
                builder: (context, state) {
                  return SocialButton(
                      isLoading: state.isFacebookLoading,
                      onTap: () {
                        context.read<AuthCubit>().loginFacebook(() {
                          Navigator.pushAndRemoveUntil(
                              context, Routes.goMain(), (route) => false);
                        });
                      },
                      title: "Facebook");
                },
              ),
              const Spacer(),
              BlocBuilder<AuthCubit, AuthState>(
                buildWhen: (p, s) => p.isGoogleLoading != s.isGoogleLoading,
                builder: (context, state) {
                  return SocialButton(
                      isLoading: state.isGoogleLoading,
                      onTap: () {
                        context.read<AuthCubit>().loginGoogle(() {
                          Navigator.pushAndRemoveUntil(
                              context, Routes.goMain(), (route) => false);
                        });
                      },
                      title: "Google");
                },
              ),
              const Spacer(flex: 6),
            ],
          ),
        ),
      ),
    );
  }
}
