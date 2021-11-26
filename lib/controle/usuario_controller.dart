
import 'package:login_screen/controle/app_database.dart';
import 'package:login_screen/modelo/beans/tipo_receita.dart';
import 'package:login_screen/modelo/beans/usuario.dart';

class UsuarioContoller {
  static const String table_name = 'usuario';

  static Future<int> save(Usuario usuario){
    return createDatabase.then((db) {
      return db.insert(table_name, usuario.toMap());
    });
  }
  static Future<List<Usuario>> findAll(){
    return createDatabase.then((db) {
      return db.query(table_name)
          .then((maps) => maps.map((e) => Usuario.fromMap(e)).toList());
    });
  }

  static Future<void> delete(int id){
    return createDatabase.then(
      (db) => db.delete(table_name, where: 'id = ?', whereArgs: [id])
    );
  }

  static Future<int> update(Usuario usuario){
    return createDatabase.then((db) {
      return db.update(
          table_name, usuario.toMap(),
          where: 'id = ?', whereArgs: [usuario.id]
      );
    });
  }
}