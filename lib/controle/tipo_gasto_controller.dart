
import 'package:login_screen/controle/app_database.dart';
import 'package:login_screen/modelo/beans/tipo_gasto.dart';

class TipoGastoContoller {
  static const String table_name = 'tipo_gasto';

  static Future<int> save(TipoGasto tipoGasto){
    return createDatabase.then((db) {
      return db.insert(table_name, tipoGasto.toMap());
    });
  }

  static Future<List<TipoGasto>> findAll(){
    return createDatabase.then((db) {
      return db.query(table_name)
          .then((maps) => maps.map((e) => TipoGasto.fromMap(e)).toList());
    });
  }

  static Future<void> delete(int id){
    return createDatabase.then(
      (db) => db.delete(table_name, where: 'id = ?', whereArgs: [id])
    );
  }

  static Future<int> update(TipoGasto tipoGasto){
    return createDatabase.then((db) {
      return db.update(
          table_name, tipoGasto.toMap(),
          where: 'id = ?', whereArgs: [tipoGasto.id]
      );
    });
  }
}