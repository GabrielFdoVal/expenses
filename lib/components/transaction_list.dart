import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'transaction_item.dart';

class TransactionList extends StatelessWidget {
  List<Transaction> transaction;
  final void Function(String) deleteTransaction;

  TransactionList(this.transaction, this.deleteTransaction, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return transaction.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Nenhuma transação cadastrada",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: transaction.length,
            itemBuilder: (ctx, index) {
              final tr = transaction[index];
              return TransactionItem(
                key: GlobalObjectKey(tr),
                tr: tr,
                deleteTransaction: deleteTransaction,
              );
            },
          );
  }
}
