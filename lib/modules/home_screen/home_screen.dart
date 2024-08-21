import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lask/shared/components/list_card.dart';
import 'package:lask/shared/local/app_cubit/app_cubit.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return (state is LoadingTopNews ||
                AppCubit.get(context).topHeadlines == null)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                margin: EdgeInsetsDirectional.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Top headlines',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              AppCubit.get(context).changeIndex(1);
                            },
                            child: Text(
                              'see more',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 300,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          reverse: true,
                          itemBuilder: (BuildContext context, int index) {
                            return ListCard(
                                article: AppCubit.get(context)
                                    .topHeadlines!
                                    .articles[index]);
                            return null;
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 100,
                              width: 20,
                            );
                          },
                          itemCount: 5,
                        ),
                      )
                    ],
                  ),
                ),
              );
      },
    );
  }
}
