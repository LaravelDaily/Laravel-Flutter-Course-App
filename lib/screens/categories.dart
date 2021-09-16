import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_first_app/models/category.dart';
import 'package:my_first_app/services/api.dart';
import 'package:my_first_app/widgets/CategoryEdit.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late Future<List<Category>> futureCategories;
  ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    futureCategories = apiService.fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Categories'),
        ),
        body: FutureBuilder<List<Category>>(
            future: futureCategories,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Category category = snapshot.data![index];
                    return ListTile(
                      title: Text(category.name),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) {
                                return CategoryEdit(category);
                              }
                          );
                        },
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              return CircularProgressIndicator();
            }));
  }
}
