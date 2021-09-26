import 'package:flutter/material.dart';
import 'package:my_first_app/models/transaction.dart';
import 'package:my_first_app/widgets/TransactionAdd.dart';
import 'package:my_first_app/widgets/TransactionsEdit.dart';
import 'package:provider/provider.dart';
import 'package:my_first_app/providers/TransactionProvider.dart';

class Transactions extends StatefulWidget {
  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransactionProvider>(context);
    List<Transaction> transactions = provider.transactions;

    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          Transaction transaction = transactions[index];
          return ListTile(
            title: Text('\$' + transaction.amount),
            subtitle: Text(transaction.categoryName),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(transaction.transactionDate),
                Text(transaction.description),
              ]),
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return TransactionEdit(
                            transaction, provider.updateTransaction);
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
                                onPressed: () => deleteTransaction(
                                    provider.deleteTransaction, transaction, context)),
                          ],
                        );
                      });
                },
              )
            ]),
          );
        },
      ),
      floatingActionButton: new FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return TransactionAdd(provider.addTransaction);
                });
          },
          child: Icon(Icons.add)),
    );
  }

  Future deleteTransaction(Function callback, Transaction transaction, BuildContext context) async {
    await callback(transaction);
    Navigator.pop(context);
  }
}
