import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './models/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    return MaterialApp(
      home: MyHomePage(),
      title: 'Personal Expenses',
      theme: ThemeData(
          primarySwatch: Colors.indigo,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: const TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                button: const TextStyle(
                  color: Colors.white,
                ),
              ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          )),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];

  List<Transaction> get recentTx {
    return _transactions.where((e) {
      return e.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime date) {
    final newTx = Transaction(
      amount: amount,
      title: title,
      date: date,
      id: DateTime.now().toString(),
    );

    setState(() {
      _transactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere(
        (tx) => tx.id == id,
      );
    });
  }

  void _startAddNewTx(ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (bCtx) => GestureDetector(
        onTap: () {},
        child: NewTransaction(_addNewTransaction),
        behavior: HitTestBehavior.opaque,
      ),
    );
  }

  bool _chart = false;

  @override
  Widget build(BuildContext ctx) {
    final _mq = MediaQuery.of(context);
    final bool _lMode = _mq.orientation == Orientation.landscape;
    final PreferredSizeWidget _appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              'Personal Expenses',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  onTap: () => _startAddNewTx(ctx),
                  child: Icon(CupertinoIcons.add),
                ),
              ],
            ))
        : AppBar(
            title: Text(
              'Personal Expenses',
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _startAddNewTx(ctx),
              )
            ],
          );
    final _tList = Container(
      height:
          (_mq.size.height - _appBar.preferredSize.height - _mq.padding.top) *
              (_lMode ? .846 : .75),
      child: Expanded(
        child: TransactionList(_transactions, _deleteTransaction),
      ),
    );

    final _body = SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (_lMode)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Show Chart',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Switch.adaptive(
                  activeColor: Theme.of(context).accentColor,
                  value: _chart,
                  onChanged: (val) {
                    setState(() {
                      _chart = val;
                    });
                  },
                )
              ],
            ),
          if (!_lMode)
            Container(
              height: (_mq.size.height -
                      _appBar.preferredSize.height -
                      _mq.padding.top) *
                  .25,
              child: Chart(recentTx),
            ),
          if (!_lMode) _tList,
          if (_lMode && _chart)
            Container(
              height: (_mq.size.height -
                      _appBar.preferredSize.height -
                      _mq.padding.top) *
                  .7,
              child: Chart(recentTx),
            ),
          if (_lMode && !_chart) _tList,
        ],
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: _body,
            navigationBar: _appBar,
          )
        : Scaffold(
            appBar: _appBar,
            body: _body,
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _startAddNewTx(ctx),
                  ),
          );
  }
}
