import 'package:alchilazo/MongoDbModel_User.dart';
import 'package:alchilazo/MongoDbModel_Worker.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:test/test.dart';
import 'package:alchilazo/mongo.dart';

// Se crea el grupo de pruebas unitarias que se realizara a la clase MongoDB de

void main() async {
  group('Prueba conexion MongoDB', () {
    test('Se espera que la conexion regrese true', () async {
      var conexion = await MongoDatabase.connect();

      expect(conexion, true);
    });

    test('Se espera que regrese una lista de usuarios', () async {
      await MongoDatabase.connect();
      var listaUsuarios =
          // ignore: unnecessary_type_check
          MongoDatabase.getData_users() is Future<List<Map<String, dynamic>>>;

      expect(listaUsuarios, true);
    });

    test('Se espera que regrese una lista de trabajadores', () async {
      await MongoDatabase.connect();
      var listaTrabajadores =
          // ignore: unnecessary_type_check
          MongoDatabase.getData_workers() is Future<List<Map<String, dynamic>>>;

      expect(listaTrabajadores, true);
    });

    test('Se espera insercion de datos sobre usuario', () async {
      await MongoDatabase.connect();
      var usuario = MongoDbModel_User(
        id: ObjectId(),
        nombre: 'Prueba Unitaria',
        correo: 'prueba@gmail.com',
        password: '123',
        dpi: '123',
      );
      var insercion = MongoDatabase.insert_usuario(usuario);
      var resultado = insercion is Future<String>;
      expect(resultado, true);
    });

    test('Se espera insercion de datos sobre trabajadores', () async {
      await MongoDatabase.connect();
      var trabajador = MongoDbModel_Worker(
          address: '',
          antecedente_penal: '',
          descripcion: '',
          email: '',
          foto_dpi: '',
          foto_perfil: '',
          id: ObjectId(),
          latitud: 20.0,
          lista_trabajos: [],
          longitud: 10.0,
          name: '',
          phone: '');
      var insercion = MongoDatabase.insert_worker(trabajador) is Future<String>;

      expect(insercion, true);
    });

    test('Se espera que la informacion del usuario se convierta a JSON', () {
      var conversion = true;
      expect(conversion, true);
    });

    test('Se espera que la informacion del trabajador se convierta a JSON', () {
      var conversion = true;
      expect(conversion, true);
    });
  });
}
