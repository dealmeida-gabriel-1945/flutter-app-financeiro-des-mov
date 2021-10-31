import 'package:flutter/material.dart';

class ItemListPlaceHolder extends StatelessWidget{

  const ItemListPlaceHolder ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: const [
                Text(
                  'Nenhum dado encontrado',
                  style: TextStyle(
                      fontSize: 20
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}
