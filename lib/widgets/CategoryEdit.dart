import 'package:my_first_app/models/category.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/services/api.dart';

class CategoryEdit extends StatefulWidget {
  final Category category;

  CategoryEdit(this.category, {Key? key}) : super(key: key);

  @override
  _CategoryEditState createState() => _CategoryEditState();
}

class _CategoryEditState extends State<CategoryEdit> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final categoryNameController = TextEditingController();
  ApiService apiService = ApiService();
  String errorMessage = '';

  @override
  void initState() {
    categoryNameController.text = widget.category.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                onChanged: (text) => setState(() => errorMessage = ''),
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
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                      child: Text('Cancel'),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ]),
              Text(errorMessage, style: TextStyle(color: Colors.red))
            ])));
  }

  Future saveCategory() async {
    final form = _formKey.currentState;

    if (!form!.validate()) {
      return;
    }

    apiService
        .updateCategory(widget.category.id, categoryNameController.text)
        .then((Category category) => Navigator.pop(context))
        .catchError((exception) {
      setState(() {
        errorMessage = exception.toString();
      });
    });
  }
}
