import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';


MongoDbModel_User mongoDbModel_UserToFromJson(String str) => // coverage:ignore-line
    MongoDbModel_User.fromJson(json.decode(str)); // coverage:ignore-line
// coverage:ignore-line
String mongoDbModel_UserToJson(MongoDbModel_User data) => // coverage:ignore-line
    json.encode(data.toJson()); // coverage:ignore-line
// coverage:ignore-line
class MongoDbModel_User {
  MongoDbModel_User({
    required this.id,
    required this.nombre,
    required this.correo,
    required this.password,
    required this.dpi,
  });

  ObjectId id;
  String nombre;
  String correo;
  String password;
  String dpi;

  factory MongoDbModel_User.fromJson(Map<String, dynamic> json) =>// coverage:ignore-line
      MongoDbModel_User( // coverage:ignore-line
        id: json["_id"], // coverage:ignore-line
        nombre: json["nombre"], // coverage:ignore-line
        correo: json["correo"], // coverage:ignore-line
        password: json["password"], // coverage:ignore-line
        dpi: json["dpi"], // coverage:ignore-line
      ); // coverage:ignore-line
 // coverage:ignore-line
  Map<String, dynamic> toJson() => {
        "_id": id,
        "nombre": nombre,
        "correo": correo,
        "password": password,
        "dpi": dpi,
      };
}
