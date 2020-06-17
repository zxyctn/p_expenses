import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double total;
  final double percent;

  ChartBar(this.label, this.total, this.percent);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, cons) {
        return Column(
          children: <Widget>[
            Container(
              height: cons.maxHeight * 0.15,
              child: FittedBox(
                child: Text('\$${total.toStringAsFixed(0)}'),
              ),
            ),
            SizedBox(
              height: cons.maxHeight * 0.05,
            ),
            Container(
              height: cons.maxHeight * 0.6,
              width: 10,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 1,
                      ),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: percent,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: cons.maxHeight * 0.05,
            ),
            Container(
              height: cons.maxHeight * 0.15,
              child: FittedBox(
                child: Text(label),
              ),
            ),
          ],
        );
      },
    );
  }
}
