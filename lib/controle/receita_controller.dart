
import 'package:login_screen/controle/app_database.dart';
import 'package:login_screen/controle/tipo_receita_controller.dart';
import 'package:login_screen/modelo/beans/receita.dart';

class ReceitaContoller {
  static const String table_name = 'receita';

  static Future<int> save(Receita receita){
    return createDatabase.then((db) {
      return db.insert(table_name, receita.toMap());
    });
  }

  static Future<List<Receita>> findAll(){
    return createDatabase.then((db) {
      return db.rawQuery(
        'SELECT receita.id as id, receita.observacoes as observacoes, receita.data_hora as data_hora, receita.valor as valor, '
            'tipo.id as tipoId, tipo.nome as tipoNome, tipo.descricao as tipoDescricao '
            'FROM $table_name as receita LEFT JOIN ${TipoReceitaContoller.table_name} as tipo'
            ' ON receita.tipo_receita_id = tipo.id;'
      ).then((maps) =>
          maps.map((e) => Receita.fromMap(e)).toList()
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
        'SELECT COUNT(receita.id) as contagem '
        'FROM $table_name as receita '
        'WHERE receita.tipo_receita_id = $idTipo;'
      ).then(
        (maps) {
          var contagem = int.tryParse(maps[0]['contagem'].toString() ?? '0');
          return contagem != null && contagem > 0;
        }
      );
    });
  }

  static Future<int> update(Receita receita){
    return createDatabase.then((db) {
      return db.update(
          table_name, receita.toMap(),
          where: 'id = ?', whereArgs: [receita.id]
      );
    });
  }
}