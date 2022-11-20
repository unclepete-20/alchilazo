import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:mongo_dart/mongo_dart.dart';

MongoDbModel_Worker mongoDbModelFromJson(String str) => // coverage:ignore-line
    MongoDbModel_Worker.fromJson(json.decode(str)); // coverage:ignore-line

String mongoDbModelToJson(MongoDbModel_Worker data) => // coverage:ignore-line
    json.encode(data.toJson()); // coverage:ignore-line

class MongoDbModel_Worker { 
  MongoDbModel_Worker({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.descripcion,
    required this.foto_dpi,
    required this.antecedente_penal,
    required this.foto_perfil,
    required this.lista_trabajos,
    required this.latitud,
    required this.longitud,
  });

  ObjectId id;
  String name;
  String address;
  String phone;
  String email;
  String descripcion;
  String foto_dpi;
  String antecedente_penal;
  String foto_perfil;
  List lista_trabajos;
  double latitud;
  double longitud;

  factory MongoDbModel_Worker.fromJson(Map<String, dynamic> json) => // coverage:ignore-line
      MongoDbModel_Worker( // coverage:ignore-line
        id: json["_id"], // coverage:ignore-line
        name: json["name"], // coverage:ignore-line
        address: json["address"], // coverage:ignore-line
        phone: json["phone"], // coverage:ignore-line
        email: json["email"], // coverage:ignore-line
        descripcion: json["descripcion"], // coverage:ignore-line
        foto_dpi: json["foto_dpi"], // coverage:ignore-line
        antecedente_penal: json["antecedente_penal"], // coverage:ignore-line
        foto_perfil: json["foto_perfil"], // coverage:ignore-line
        lista_trabajos: json["lista_trabajos"], // coverage:ignore-line
        latitud: json["latitud"], // coverage:ignore-line
        longitud: json["longitud"], // coverage:ignore-line
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "address": address,
        "phone": phone,
        "email": email,
        "descripcion": descripcion,
        "foto_dpi": foto_dpi,
        "antecedente_penal": antecedente_penal,
        "foto_perfil": foto_perfil,
        "lista_trabajos": lista_trabajos,
        "latitud": latitud,
        "longitud": longitud,
      };
}
