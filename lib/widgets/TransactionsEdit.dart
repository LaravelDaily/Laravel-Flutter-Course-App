import 'package:my_first_app/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionEdit extends StatefulWidget {
  final Transaction transaction;
  final Function transactionCallback;

  TransactionEdit(this.transaction, this.transactionCallback, {Key? key}) : super(key: key);

  @override
  _TransactionEditState createState() => _TransactionEditState();
}

class _TransactionEditState extends State<TransactionEdit> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final categoryNameController = TextEditingController();
  String errorMessage = '';

  @override
  void initState() {
    categoryNameController.text = widget.transaction.amount;
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
                      onPressed: () => saveTransaction(context),
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

  Future saveTransaction(context) async {
    final form = _formKey.currentState;

    if (!form!.validate()) {
      return;
    }

    widget.transaction.amount = categoryNameController.text;

    await widget.transactionCallback(widget.transaction);
    Navigator.pop(context);
  }
}
