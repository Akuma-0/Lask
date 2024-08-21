import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lask/shared/components/city_item.dart';
import 'package:lask/shared/local/app_cubit/app_cubit.dart';

class SelectCity extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            toolbarHeight: 90,
            title: Text(
              'City',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: searchController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Search city',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            prefixIcon: Icon(Icons.search),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "City name can't be empty";
                            }
                            return null;
                          },
                          onFieldSubmitted: (value) async {
                            await AppCubit.get(context).cityMaker(value);
                          },
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      return CityItem(
                        city: AppCubit.get(context).cities[index],
                      );
                    },
                    itemCount: (AppCubit.get(context).cities == null)
                        ? 0
                        : AppCubit.get(context).cities.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 10,
                      );
                    },
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
