
import 'package:flutter/material.dart';

class YesNoDialog extends StatelessWidget {

  final _onYes;
  final _onNo;
  var title;
  var bodyText;
  var yesText;
  var noText;


  YesNoDialog(
    this._onYes, this._onNo,
    [
      this.title = "Atenção!",
      this.bodyText = "Você deseja realizar esta ação?",
      this.yesText = "Sim",
      this.noText = "Não",
    ]);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(bodyText),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(yesText),
          onPressed: () {
            _onYes();
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(noText),
          onPressed: () {
            _onNo();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
