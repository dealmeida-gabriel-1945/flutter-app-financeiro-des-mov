
import 'package:login_screen/controle/app_database.dart';
import 'package:login_screen/controle/tipo_gasto_controller.dart';
import 'package:login_screen/modelo/beans/gasto.dart';

class GastoContoller {
  static const String table_name = 'gasto';

  static Future<int> save(Gasto gasto){
    return createDatabase.then((db) {
      return db.insert(table_name, gasto.toMap());
    });
  }

  static Future<List<Gasto>> findAll(){
    return createDatabase.then((db) {
      return db.rawQuery(
        'SELECT gasto.id as id, gasto.observacoes as observacoes, gasto.data_hora as data_hora, gasto.valor as valor, '
            'tipo.id as tipoId, tipo.nome as tipoNome, tipo.descricao as tipoDescricao '
            'FROM $table_name as gasto LEFT JOIN ${TipoGastoContoller.table_name} as tipo'
            ' ON gasto.tipo_gasto_id = tipo.id;'
      ).then((maps) =>
          maps.map((e) => Gasto.fromMap(e)).toList()
      );
    });
  }

  static Future<void> delete(int id){
    return createDatabase.then(
      (db) => db.delete(table_name, where: 'id = ?', whereArgs: [id])
    );
  }

  static Future<bool> existsByTipo(int idTipo){
    return createDatabase.then((db) {
      return db.rawQuery(
        'SELECT COUNT(gasto.id) as contagem '
        'FROM $table_name as gasto '
        'WHERE gasto.tipo_gasto_id = $idTipo;'
      ).then(
        (maps) {
          var contagem = int.tryParse(maps[0]['contagem'].toString() ?? '0');
          return contagem != null && contagem > 0;
        }
      );
    });
  }

  static Future<int> update(Gasto gasto){
    return createDatabase.then((db) {
      return db.update(
          table_name, gasto.toMap(),
          where: 'id = ?', whereArgs: [gasto.id]
      );
    });
  }
}