
import 'package:login_screen/controle/app_database.dart';
import 'package:login_screen/modelo/beans/receita.dart';

class ReceitaContoller {
  static String _table_name = 'receita';

  static Future<int> save(Receita receita){
    return createDatabase.then((db) {
      return db.insert(_table_name, receita.toMap());
    });
  }

  static Future<List<Receita>> findAll(){
    return createDatabase.then((db) {
      return db.query(_table_name)
          .then((maps) => maps.map((e) => Receita.fromMap(e)).toList());
    });
  }

  static Future<void> delete(int id){
    return createDatabase.then(
      (db) => db.delete(_table_name, where: 'id = ?', whereArgs: [id])
    );
  }
}