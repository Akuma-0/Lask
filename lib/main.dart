import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:lask/layout/home_layout.dart';
import 'package:lask/modules/intro/intro_screen.dart';
import 'package:lask/shared/local/app_cubit/app_cubit.dart';
import 'package:lask/shared/local/hive/hive_helper.dart';
import 'package:lask/theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'models/article/article.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapter(ArticleAdapter());
  data = await openHiveBox('data');
  saved = await openHiveBox('articlesBox');
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()
        ..topHeadlinesMaker()
        ..themeFromHive()
        ..cityFromHive()
        ..weatherMaker(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: lightMode,
            themeMode: AppCubit.get(context).theme,
            darkTheme: darkMode,
            debugShowCheckedModeBanner: false,
            home: (data!.get('newUser') == null) ? IntroScreen() : HomeLayout(),
          );
        },
      ),
    );
  }
}
