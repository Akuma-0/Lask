import 'package:floating_tabbar/lib.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lask/models/weather/city.dart';
import 'package:lask/shared/local/app_cubit/app_cubit.dart';

class CityItem extends StatelessWidget {
  City city;

  CityItem({required this.city});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return InkWell(
          onTap: () {
            AppCubit.get(context).changeCity(city);
            Navigator.pop(context);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  city.name,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text(
                  city.state,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text(
                  city.country,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
