import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(
      7,
      (i) {
        final _day = DateTime.now().subtract(Duration(days: i));
        double _total = 0;

        for (var j = 0; j < recentTransactions.length; j++) {
          if (recentTransactions[j].date.day == _day.day &&
              recentTransactions[j].date.month == _day.month &&
              recentTransactions[j].date.year == _day.year) {
            _total += recentTransactions[j].amount;
          }
        }

        return {
          'day': DateFormat.E().format(_day).substring(0, 1),
          'amount': _total,
        };
      },
    ).reversed.toList();
  }

  double get total {
    return groupedTransactionValues.fold(
      0.0,
      (sum, e) => sum + e['amount'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(data['day'], data['amount'],
                  total == 0.0 ? 0.0 : (data['amount'] as double) / total),
            );
          }).toList(),
        ),
      ),
    );
  }
}
