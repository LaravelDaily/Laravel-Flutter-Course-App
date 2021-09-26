import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:my_first_app/models/category.dart';
import 'package:provider/provider.dart';
import 'package:my_first_app/providers/CategoryProvider.dart';

class TransactionAdd extends StatefulWidget {
  final Function transactionCallback;

  TransactionAdd(this.transactionCallback, {Key? key}) : super(key: key);

  @override
  _TransactionAddState createState() => _TransactionAddState();
}

class _TransactionAddState extends State<TransactionAdd> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final transactionAmountController = TextEditingController();
  final transactionCategoryController = TextEditingController();
  final transactionDescriptionController = TextEditingController();
  final transactionDateController = TextEditingController();
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 50, left: 10, right: 10),
        child: Form(
            key: _formKey,
            child: Column(children: <Widget>[
              TextFormField(
                controller: transactionAmountController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^-?(\d+\.?\d{0,2})?')),
                ],
                keyboardType: TextInputType.numberWithOptions(
                    signed: true, decimal: true),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Amount',
                  icon: Icon(Icons.attach_money),
                  hintText: '0',
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return 'Amount is required';
                  }
                  final newValue = double.tryParse(value);

                  if (newValue == null) {
                    return 'Invalid amount format';
                  }
                },
                onChanged: (text) => setState(() => errorMessage = ''),
              ),
              buildCategoriesDropdown(),
              TextFormField(
                controller: transactionDescriptionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return 'Description is required';
                  }

                  return null;
                },
                onChanged: (text) => setState(() => errorMessage = ''),
              ),
              TextFormField(
                controller: transactionDateController,
                onTap: () {
                  selectDate(context);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Transaction date',
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return 'Date is required';
                  }

                  return null;
                },
                onChanged: (text) => setState(() => errorMessage = ''),
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

  Future selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5)
    );
    if (picked != null)
      setState(() {
        transactionDateController.text = DateFormat('MM/dd/yyyy').format(picked);
      });
  }

  Widget buildCategoriesDropdown() {
    return Consumer<CategoryProvider>(
      builder: (context, cProvider, child) {
        List<Category> categories = cProvider.categories;

        return DropdownButtonFormField(
          elevation: 8,
          items: categories.map<DropdownMenuItem<String>>((e) {
            return DropdownMenuItem<String>(
                value: e.id.toString(),
                child: Text(e.name,
                    style: TextStyle(color: Colors.black, fontSize: 20.0)));
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue == null) {
              return;
            }

            setState(() {
              transactionCategoryController.text = newValue.toString();
            });
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Category',
          ),
          dropdownColor: Colors.white,
          validator: (value) {
            if (value == null) {
              return 'Please select category';
            }
          },
        );
      },
    );
  }

  Future saveTransaction(context) async {
    final form = _formKey.currentState;

    if (!form!.validate()) {
      return;
    }

    await widget.transactionCallback(
        transactionAmountController.text,
        transactionCategoryController.text,
        transactionDescriptionController.text,
        transactionDateController.text
    );
    Navigator.pop(context);
  }

}
