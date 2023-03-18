import 'package:demos_ai/presentation/pages/home/widgets/home_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../application/app_cubit/app_cubit.dart';
import '../../../application/home_cubit/home_cubit.dart';
import '../../utils/components/my_image_network.dart';
import '../../utils/style/blur.dart';
import '../../utils/style/style.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late RefreshController _refreshController;

  @override
  void initState() {
    _refreshController = RefreshController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<HomeCubit>().getUserInfo();
    });
    super.initState();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      enablePullUp: false,
      onLoading: () {},
      onRefresh: () async {
        // context.read<HomeCubit>().getCardInfo();
        _refreshController.refreshCompleted();
      },
      child: SingleChildScrollView(
        padding: EdgeInsets.all(24.r),
        child: Column(
          children: [
            Row(
              children: [
                BlocBuilder<HomeCubit, HomeState>(
                  buildWhen: (p, s) => p.user?.avatar != s.user?.avatar,
                  builder: (context, state) {
                    return CustomImageNetwork(
                        height: 48.r, width: 48.r, image: state.user?.avatar);
                  },
                ),
                16.w.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Good Morning 👋",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      BlocBuilder<HomeCubit, HomeState>(
                        buildWhen: (p, s) => p.user?.name != s.user?.name,
                        builder: (context, state) {
                          return Text(
                            (state.user?.name?.contains(" ") == true
                                    ? state.user?.name?.substring(
                                        0, state.user?.name?.indexOf(" "))
                                    : state.user?.name) ??
                                "",
                            style: Theme.of(context).textTheme.displayMedium,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            24.h.verticalSpace,
            Row(
              children: const [
                HomeButtons(svgName: 'commment', title: 'Start Chat'),
                HomeButtons(svgName: 'marker', title: 'Info Location')
              ],
            )
          ],
        ),
      ),
    );
  }
}
