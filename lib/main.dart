import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:vinemas/features/auth/login/login_screen.dart';
import 'package:vinemas/firebase_options.dart';
import 'package:vinemas/l10n/generated/app_localizations.dart';
import 'package:vinemas/features/profile/presentation/not_found_page.dart';
import 'package:vinemas/features/profile/presentation/forgot_password_screen.dart';
import 'package:vinemas/core/common/presentation/blocs/global_info_bloc/global_info_bloc.dart';
import 'package:vinemas/core/services/injection_container.dart';
import 'package:vinemas/core/theme/my_theme.dart';
import 'package:vinemas/features/home/presentation/home_screen.dart';
import 'package:vinemas/features/profile/presentation/profile_screen.dart';
import 'package:vinemas/root_page.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
      );
  await dotenv.load(fileName: '.env');
  await initDI();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GlobalInfoBloc>(
      create: (_) => GlobalInfoBloc(getIt())..add(GetGlobalInfo()),
      child: BlocBuilder<GlobalInfoBloc, GlobalInfoState>(
        builder: (context, state) {
          return MaterialApp(
            theme: MyTheme.darkTheme(),
            //! chỉ định Ngôn ngữ cho app
            //? Dùng cho TH hệ thống đã lưu lại ngôn ngữ mà user đã chọn để sử dụng trong app
            locale: state.currentLocale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            localeResolutionCallback: (deviceLocale, supportedLocales) {
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode ==
                    deviceLocale?.languageCode) {
                  return supportedLocale;
                }
              }
              return supportedLocales.first;
            },
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case '/':
                  return MaterialPageRoute(builder: (_) => const LoginScreen());
                case 'home':
                  return MaterialPageRoute(builder: (_) => const HomeScreen());
                case 'forgot-password':
                  return MaterialPageRoute(
                      builder: (_) => const ForgotPasswordScreen());
                case 'profile':
                  return MaterialPageRoute(
                      builder: (_) => const ProfileScreen());
                default:
                  return MaterialPageRoute(
                      builder: (_) => const NotFoundPage());
              }
            },
            home: const RootPage(),
          );
        },
      ),
    );
  }
}

// NowPlayingMoviesScreen()