import 'package:alchilazo/pantalla_home.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:alchilazo/mongo.dart';
import 'MongoDbModel_User.dart';

class Servicios_Trabajador extends StatefulWidget {

  @override
  State<Servicios_Trabajador> createState() => _ServiciosTrabajador();
}

class _ServiciosTrabajador extends State<Servicios_Trabajador> {

  var lista_servicios = ["Servicio 1", "Servicio 2"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sección de Trabajador"),
        backgroundColor: Color.fromRGBO(245, 71, 72, 1),
      ),
      body: ListView(
        padding:
            EdgeInsets.only(top: 20.0, bottom: 10.0, left: 10.0, right: 10.0),
        children: <Widget>[
          Text(
            'Servicios Solicitados',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              '\nDescripción:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 15.0, bottom: 15.0),
            height: 90,
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: lista_servicios.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Center(
                      child: Text(
                    lista_servicios[index],
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  )),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),
            decoration: new BoxDecoration(
              color: Color.fromARGB(255, 255, 79, 66),
            ),
          ),
        ],
      ),
    );
  }
}