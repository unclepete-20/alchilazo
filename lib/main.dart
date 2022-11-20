import 'package:flutter/material.dart';
import 'login_page.dart';
import 'package:alchilazo/mongo.dart';

void main() => runApp(MyApp());

void connectToMongo() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //lista de trabajadores, en este caso se debe de utilizar la vista de ofrecer servicios
    //y al agregar datos se deben de agregar datos a una lista, la cual luego esta utilizara esa lista en vez de esta.
    connectToMongo();
    return MaterialApp(
      title: 'Al Chilazo',
      home: LoginPage(),
    );
  }
}

// class MyAppState extends State<MyApp> {
//   //variable global.

//   @override
//   Widget build(BuildContext context) {
//     //lista de trabajadores, en este caso se debe de utilizar la vista de ofrecer servicios
//     //y al agregar datos se deben de agregar datos a una lista, la cual luego esta utilizara esa lista en vez de esta.

//     return MaterialApp(
//       title: 'Al Chilazo',
//       home: LoginPage(),
//     );
//   }
// }
