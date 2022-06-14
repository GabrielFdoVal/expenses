import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.tr,
    required this.deleteTransaction,
  }) : super(key: key);

  final Transaction tr;
  final void Function(String p1) deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Theme.of(context).colorScheme.primary,
          ),
          margin: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          padding: EdgeInsets.all(10),
          child: FittedBox(
            child: Text(
              'R\$ ${tr.value.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
        ),
        title: Text(
          tr.title,
          style: Theme.of(context).textTheme.headline2,
        ),
        subtitle: Text(
          DateFormat('d MMM y').format(tr.date),
        ),
        trailing: MediaQuery.of(context).size.width > 480
            ? TextButton.icon(
                onPressed: () => deleteTransaction(tr.id),
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
                label: Text(
                  "Excluir",
                  style: TextStyle(
                    color: Theme.of(context).errorColor,
                  ),
                ),
              )
            : IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => deleteTransaction(tr.id),
              ),
      ),
    );
  }
}
