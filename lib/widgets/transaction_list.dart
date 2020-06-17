import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function delTx;

  TransactionList(this._transactions, this.delTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _transactions.isEmpty
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: LayoutBuilder(
                builder: (context, cons) {
                  return Column(
                    children: <Widget>[
                      Text(
                        'No transactions added yet!',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        height: cons.maxHeight * 0.6,
                        child: Image.asset(
                          'assets/images/waiting.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  );
                },
              ),
            )
          : ListView.builder(
              itemBuilder: (ctx, i) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: FittedBox(
                            child: Text('\$${_transactions[i].amount}'),
                          ),
                        ),
                      ),
                      title: Text(
                        _transactions[i].title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd().format(_transactions[i].date),
                      ),
                      trailing: MediaQuery.of(context).size.width > 460
                          ? FlatButton.icon(
                              onPressed: () => delTx(_transactions[i].id),
                              icon: Icon(Icons.delete, color: Theme.of(context).textTheme.button.color,),
                              label: Text(
                                'Delete',
                                style: Theme.of(context).textTheme.button,
                              ),
                              color: Theme.of(context).errorColor,
                            )
                          : IconButton(
                              icon: const Icon(Icons.delete),
                              color: Theme.of(context).errorColor,
                              onPressed: () => delTx(_transactions[i].id),
                            ),
                    ),
                  ),
                );
              },
              itemCount: _transactions.length,
            ),
    );
  }
}
