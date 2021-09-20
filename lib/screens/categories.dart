import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_first_app/models/category.dart';
import 'package:my_first_app/widgets/CategoryEdit.dart';
import 'package:my_first_app/providers/CategoryProvider.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CategoryProvider>(context);
    List<Category> categories = provider.categories;

    return Scaffold(
        appBar: AppBar(
          title: Text('Categories'),
        ),
        body: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            Category category = categories[index];
            return ListTile(
              title: Text(category.name),
              trailing: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext context) {
                          return CategoryEdit(
                              category, provider.updateCategory);
                        });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Confirmation"),
                            content: Text("Are you sure you want to delete?"),
                            actions: [
                              TextButton(
                                child: Text("Cancel"),
                                onPressed: () => Navigator.pop(context),
                              ),
                              TextButton(
                                child: Text("Delete"),
                                onPressed: () => deleteCategory(provider.deleteCategory, category)
                              ),
                            ],
                          );
                        });
                  },
                )
              ]),
            );
          },
        ));
  }

  Future deleteCategory(Function callback, Category category) async {
    await callback(category);
    Navigator.pop(context);
  }

}
