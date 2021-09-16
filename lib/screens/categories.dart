import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_first_app/models/category.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late Future<List<Category>> futureCategories;
  final _formKey = GlobalKey<FormState>();
  late Category selectedCategory;
  final categoryNameController = TextEditingController();

  Future<List<Category>> fetchCategories() async {
    http.Response response = await http
        .get(Uri.parse('http://flutter-api.laraveldaily.com/api/categories'));

    List categories = jsonDecode(response.body);

    return categories.map((category) => Category.fromJson(category)).toList();
  }

  Future saveCategory() async {
    final form = _formKey.currentState;

    if (!form!.validate()) {
      return;
    }

    String uri = 'http://flutter-api.laraveldaily.com/api/categories/' + selectedCategory.id.toString();

    await http.put(Uri.parse(uri),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
      },
      body: jsonEncode({ 'name': categoryNameController.text })
    );

    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    futureCategories = fetchCategories();
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
                          selectedCategory = category;
                          categoryNameController.text = category.name;
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) {
                                return Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Form(
                                      key: _formKey,
                                      child: Column(children: <Widget>[
                                      TextFormField(
                                        controller: categoryNameController,
                                        validator: (String? value) {
                                          if (value!.isEmpty) {
                                            return 'Enter category name';
                                          }

                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Category name',
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          ElevatedButton(
                                            child: Text('Save'),
                                            onPressed: () => saveCategory(),
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.red
                                            ),
                                            child: Text('Cancel'),
                                            onPressed: () => Navigator.pop(context),
                                          ),
                                        ]
                                      )
                                    ])
                                    )
                                );
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
