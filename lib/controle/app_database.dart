import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const create_tipo_receita_tb = 'CREATE TABLE tipo_receita('
    'id INTEGER PRIMARY KEY, '
    'nome VARCHAR(50) NOT NULL, '
    'descricao VARCHAR(500));';

const create_tipo_gasto_tb = 'CREATE TABLE tipo_gasto('
    'id INTEGER PRIMARY KEY, '
    'nome VARCHAR(50) NOT NULL, '
    'descricao VARCHAR(500));';

final Future<Database> createDatabase = getDatabasesPath().then((dbPath) {
    final String path = join(dbPath, 'des_mov_db.db');
    return openDatabase(path, onCreate: (db, version){
      db.execute(create_tipo_receita_tb);
      db.execute(create_tipo_gasto_tb);
    }, version: 1);
  });

