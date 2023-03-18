import 'package:demos_ai/presentation/pages/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proste_indexed_stack/proste_indexed_stack.dart';
import '../../../application/app_cubit/app_cubit.dart';
import '../../utils/style/style.dart';
import '../home/home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      buildWhen: (p, s) => p.selected != s.selected,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: SafeArea(
            child: ProsteIndexedStack(
              index: state.selected,
              children: [
                IndexedStackChild(child: const HomePage()),
                IndexedStackChild(child: const ProfilePage()),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Theme.of(context).primaryColor,
            currentIndex: state.selected,
            onTap: (s) {
              context.read<AppCubit>().changePage(s);
            },
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  icon: state.selected == 0
                      ? SvgPicture.asset("assets/svg/home2.svg",
                          color: Style.primaryColor, height: 24, width: 24)
                      : SvgPicture.asset(
                          "assets/svg/home.svg",
                          color: Theme.of(context).secondaryHeaderColor, height: 24, width: 24
                        ),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: state.selected == 1
                      ? SvgPicture.asset("assets/svg/user2.svg",
                      color: Style.primaryColor, height: 21, width: 21)
                      : SvgPicture.asset(
                      "assets/svg/user.svg",
                      color: Theme.of(context).secondaryHeaderColor, height: 21, width: 21
                  ),
                  label: "Profile"),
            ],
          ),
        );
      },
    );
  }
}
