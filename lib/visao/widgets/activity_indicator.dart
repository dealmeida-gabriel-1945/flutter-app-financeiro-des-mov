import 'package:flutter/material.dart';

class ActivityIndicator extends StatelessWidget {

  final bool hasScaffold;
  final String appBarTitle;

  ActivityIndicator([
    this.hasScaffold = false,
    this.appBarTitle = '',
  ]);

  @override
  Widget build(BuildContext context) {
    if(!hasScaffold){
      return Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle),
        ),
        body: renderMainWidget(),
      );
    }
    return renderMainWidget();
  }

  renderMainWidget(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          CircularProgressIndicator(),
          Text('Carregando...')
        ],
      ),
    );
  }
}