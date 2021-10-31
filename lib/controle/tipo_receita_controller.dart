
import 'package:login_screen/controle/app_database.dart';
import 'package:login_screen/modelo/beans/tipo_receita.dart';

class TipoReceitaContoller {
  static String _table_name = 'tipo_receita';

  static Future<int> save(TipoReceita tipoReceita){
    return createDatabase.then((db) {
      return db.insert(_table_name, tipoReceita.toMap());
    });
  }

  static Future<List<TipoReceita>> findAll(){
    return createDatabase.then((db) {
      return db.query(_table_name)
          .then((maps) => maps.map((e) => TipoReceita.fromMap(e)).toList());
    });
  }

  static Future<void> delete(int id){
    return createDatabase.then(
      (db) => db.delete(_table_name, where: 'id = ?', whereArgs: [id])
    );
  }
}