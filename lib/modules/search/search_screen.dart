import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lask/shared/components/list_row.dart';

import '../../shared/local/app_cubit/app_cubit.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      AppCubit.get(context).searchMaker(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        centerTitle: true,
        title: Text(
          'Search',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              controller: searchController,
              focusNode: searchFocusNode,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                prefixIcon: Icon(Icons.search),
              ),
              validator: (value) {
                if (value!.isEmpty) return "search can't be empty";
                return null;
              },
              onChanged: (value) {
                _onSearchChanged(value);
              },
            ),
            SizedBox(
              height: 20,
            ),
            BlocConsumer<AppCubit, AppStates>(
              listener: (BuildContext context, AppStates state) {},
              builder: (BuildContext context, AppStates state) {
                if (state is LoadingSearch) {
                  return Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  );
                } else {
                  // Restore focus to the TextFormField
                  if (searchFocusNode.hasFocus) {
                    FocusScope.of(context).requestFocus(searchFocusNode);
                  }

                  return Expanded(
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return ListRow(
                          article:
                              AppCubit.get(context).search!.articles[index],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(
                        height: 15,
                      ),
                      itemCount: (AppCubit.get(context).search == null)
                          ? 0
                          : AppCubit.get(context).search!.articles.length,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
