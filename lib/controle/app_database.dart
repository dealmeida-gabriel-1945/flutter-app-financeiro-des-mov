import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const create_tipo_receita_tb = 'CREATE TABLE tipo_receita('
    'id INTEGER PRIMARY KEY, '
    'nome VARCHAR(45) NOT NULL, '
    'descricao TEXT);';

const create_tipo_gasto_tb = 'CREATE TABLE tipo_gasto('
    'id INTEGER PRIMARY KEY, '
    'nome VARCHAR(45) NOT NULL, '
    'descricao TEXT);';

const create_receita_tb = 'CREATE TABLE receita('
    'id INTEGER PRIMARY KEY, '
    'tipo_gasto_id INTEGER, '
    'observacoes TEXT, '
    'dataHora TIMESTAMP,'
    'valor FLOAT,'
    'FOREIGN KEY(tipo_gasto_id) REFERENCES tipo_receita(id));';

final Future<Database> createDatabase = getDatabasesPath().then((dbPath) {
    final String path = join(dbPath, 'des_mov_db.db');
    return openDatabase(path, onCreate: (db, version){
      db.execute(create_tipo_receita_tb);
      db.execute(create_tipo_gasto_tb);
      db.execute(create_receita_tb);
    }, version: 1);
  });

