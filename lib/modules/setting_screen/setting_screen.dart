import 'dart:ffi';

import 'package:floating_tabbar/Widgets/airoll.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lask/shared/local/app_cubit/app_cubit.dart';

import '../../shared/local/hive/hive_helper.dart';
import '../../theme/theme.dart';
import '../weather/select_city.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Container(
          padding: EdgeInsetsDirectional.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Theme',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              RadioListTile(
                title: const Text('System Default'),
                value: 'ThemeMode.system',
                groupValue: data!.get('theme') ?? 'ThemeMode.system',
                onChanged: (theme) {
                  cubit.changeTheme(theme);
                },
              ),
              RadioListTile(
                title: const Text('Light'),
                value: 'ThemeMode.light',
                groupValue: data!.get('theme') ?? 'ThemeMode.system',
                onChanged: (theme) {
                  cubit.changeTheme(theme);
                },
              ),
              RadioListTile(
                title: const Text('Dark'),
                value: 'ThemeMode.dark',
                groupValue: data!.get('theme') ?? 'ThemeMode.system',
                onChanged: (theme) {
                  cubit.changeTheme(theme);
                },
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: 2,
                color: Theme.of(context).colorScheme.secondary,
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SelectCity()),
                  );
                },
                child: (cubit.city == null)
                    ? Container(
                        padding: EdgeInsetsDirectional.only(top: 20, start: 10),
                        child: Text(
                          'Click to choose city',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.blue,
                          ),
                        ),
                      )
                    : Container(
                        padding: EdgeInsetsDirectional.all(10),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cubit.city.name,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              cubit.city.country,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            )
                          ],
                        ),
                      ),
              )
            ],
          ),
        );
      },
    );
  }
}
