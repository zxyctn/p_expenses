import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final Function _submit;

  AdaptiveFlatButton(this._submit);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text('Add transaction'),
            onPressed: _submit,
          )
        : FlatButton(
            child: Text('Add transaction'),
            onPressed: _submit,
            color: Theme.of(context).primaryColor,
            textColor: Theme.of(context).textTheme.button.color,
          );
  }
}

class AdaptiveDatePickerButton extends StatelessWidget {
  final Function _showDatePicker;

  AdaptiveDatePickerButton(this._showDatePicker);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(
              'Choose Date',
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Theme.of(context).primaryColor,
              ),
            ),
            onPressed: _showDatePicker,
          )
        : FlatButton(
            textColor: Theme.of(context).primaryColor,
            child: Text(
              'Choose Date',
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Theme.of(context).primaryColor,
              ),
            ),
            onPressed: _showDatePicker,
          );
  }
}
