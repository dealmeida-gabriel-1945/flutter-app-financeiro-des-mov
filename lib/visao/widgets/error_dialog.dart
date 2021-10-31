
import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {

  var title;
  var bodyText;


  ErrorDialog({
    this.title = "Erro!",
    this.bodyText = "Algo de errado aconteceu :(",
  });

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
          child: const Text('Ok!'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
