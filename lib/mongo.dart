import 'dart:developer';
import 'package:alchilazo/MongoDbModel_Order.dart';
import 'package:alchilazo/MongoDbModel_User.dart';
import 'package:alchilazo/MongoDbModel_Worker.dart';
import 'package:alchilazo/constant.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static var db, userCollection, workerCollection, ordersCollection;
  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    inspect(db);
    userCollection = db.collection(USER_COLLECTION);
    workerCollection = db.collection(WORKER_COLLECTION);
    ordersCollection = db.collection(ORDERS_COLLECTION);
    return true;
  }

  static Future<List<Map<String, dynamic>>> getData_users() async {
    final arrData = await userCollection.find().toList();
    return arrData;
  }

  static Future<List<Map<String, dynamic>>> getData_workers() async {
    final arrData = await workerCollection.find().toList();
    return arrData;
  }

  static Future<List<Map<String, dynamic>>> getData_Orders() async {
    final arrData = await ordersCollection.find().toList();
    return arrData;
  }

  static Future<String> insert_usuario(MongoDbModel_User data) async {
    try {
      var result = await userCollection.insertOne(data.toJson());
      if (result.isSuccess) {
        return "Data insertada";
      } else {
        return "Algo ocurrio";
      }
    } catch (e) {
      print(e.toString()); // coverage:ignore-line
      return e.toString(); // coverage:ignore-line
    }
  }

  static Future<String> insert_worker(MongoDbModel_Worker data) async {
    try {
      var result = await workerCollection.insertOne(data.toJson());
      if (result.isSuccess) {
        return "Data insertada";
      } else {
        return "Algo ocurrio";
      }
    } catch (e) {
      print(e.toString()); // coverage:ignore-line
      return e.toString(); // coverage:ignore-line
    }
  }

  static Future<String> insert_order(MongoDbModel_Order data) async {
    try {
      var result = await ordersCollection.insertOne(data.toJson());
      if (result.isSuccess) {
        return "Data insertada";
      } else {
        return "Algo ocurrio";
      }
    } catch (e) {
      print(e.toString()); // coverage:ignore-line
      return e.toString(); // coverage:ignore-line
    }
  }

}