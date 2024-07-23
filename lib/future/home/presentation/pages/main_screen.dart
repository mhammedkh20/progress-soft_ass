import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_soft_ass/core/components/my_app_bar.dart';
import 'package:progress_soft_ass/core/components/my_text.dart';
import 'package:progress_soft_ass/core/components/my_toggle_button.dart';
import 'package:progress_soft_ass/core/services/notification_service.dart';
import 'package:progress_soft_ass/core/storage/pref/shared_pref_controller.dart';
import 'package:progress_soft_ass/core/utils/app_colors.dart';
import 'package:progress_soft_ass/core/utils/app_helpers.dart';
import 'package:progress_soft_ass/future/auth/presentation/pages/login_screen.dart';
import 'package:progress_soft_ass/future/home/models/page_widget.dart';
import 'package:progress_soft_ass/future/home/presentation/manager/home_bloc/home_bloc.dart';
import 'package:progress_soft_ass/future/home/presentation/manager/language_bloc/language_bloc.dart';
import 'package:progress_soft_ass/future/home/presentation/manager/main_bloc/main_bloc.dart';
import 'package:progress_soft_ass/future/home/presentation/widgets/home_page.dart';
import 'package:progress_soft_ass/future/home/presentation/widgets/profile_data.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late List<PageWidget> listPages;
  @override
  void didChangeDependencies() {
    listPages = [
      PageWidget(
        title: AppLocalizations.of(context)!.home_tab,
        widget: const HomePage(),
        icon: Icons.home,
      ),
      PageWidget(
        title: AppLocalizations.of(context)!.profile_tab,
        widget: const ProfileData(),
        icon: Icons.person,
      ),
    ];
    super.didChangeDependencies();
  }

  @override
  void initState() {
    context.read<HomeBloc>().add(GetDataUserEvent());

    context.read<HomeBloc>().add(GetPostsEvent());
    NotificationService.init();
    NotificationService.requestIOSPermissions();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      if (notification != null) {
        if (notification.title != null) {
          NotificationService.showNotification(
            id: notification.hashCode,
            title: notification.title ?? "",
            body: notification.body ?? "",
            urlImage: notification.android?.imageUrl,
          );
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: AppLocalizations.of(context)!.main_screen,
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<LanguageBloc, LanguageState>(
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () {
                      context
                          .read<LanguageBloc>()
                          .add(LanguageEvent(state.lang));
                    },
                    child: MyText(
                      title: state.lang,
                      textAlign: TextAlign.center,
                      color: AppColors.WHITE,
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(width: 16.w),
        ],
        leading: IconButton(
          icon: const Icon(Icons.logout_outlined),
          onPressed: () async {
            await SharedPrefController().clearAllData();
            AppHelpers.navigationToPageAndExitAll(context, LoginScreen());
          },
        ),
      ),
      body: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          return Column(
            children: [
              SizedBox(height: 10.h),
              MyTapBar(
                indexSelected: state.indexTap,
                title: null,
                values: [listPages[0].title, listPages[1].title],
              ),
              SizedBox(height: 10.h),
              Expanded(child: listPages[state.indexTap].widget),
            ],
          );
        },
      ),
    );
  }
}
