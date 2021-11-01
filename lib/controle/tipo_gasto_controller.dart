
import 'package:login_screen/controle/app_database.dart';
import 'package:login_screen/modelo/beans/tipo_gasto.dart';

class TipoGastoContoller {
  static const String _table_name = 'tipo_gasto';

  static Future<int> save(TipoGasto tipoGasto){
    return createDatabase.then((db) {
      return db.insert(_table_name, tipoGasto.toMap());
    });
  }

  static Future<List<TipoGasto>> findAll(){
    return createDatabase.then((db) {
      return db.query(_table_name)
          .then((maps) => maps.map((e) => TipoGasto.fromMap(e)).toList());
    });
  }

  static Future<void> delete(int id){
    return createDatabase.then(
      (db) => db.delete(_table_name, where: 'id = ?', whereArgs: [id])
    );
  }
}