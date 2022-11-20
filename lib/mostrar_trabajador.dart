import 'package:alchilazo/contratar.dart';
import 'package:alchilazo/register_worker.dart';
import 'package:alchilazo/services_screen.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:flutter/material.dart';
import 'MongoDbModel_Worker.dart';
import 'mongo.dart';

class ViewWorker extends StatefulWidget {
  const ViewWorker({Key? key, required this.trabajo, required this.correo}) : super(key: key);
  final String trabajo;
  final String correo;

  @override
  State<ViewWorker> createState() => _ServicesWorkers();
}

class _ServicesWorkers extends State<ViewWorker> {
  var arrData = [];
  var trabajadores = [];

  Future _getData() async {
    arrData = await MongoDatabase.getData_workers();
    setState(() {});
    for (int i = 0; i < arrData.length; i++) {
      for (int j = 0; j < arrData[i]["lista_trabajos"].length; j++) {
        if (arrData[i]["lista_trabajos"][j] == widget.trabajo) {
          trabajadores.add(arrData[i]);
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getData();
    });
  }

  final String imageUrl =
      "https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Trabajadores"),
          backgroundColor: Color.fromRGBO(245, 71, 72, 1),
        ),
        backgroundColor: Colors.white,
        body: ListView.builder(
            padding: const EdgeInsets.all(5.5),
            itemCount: trabajadores.length,
            itemBuilder: _itemBuilder),
        resizeToAvoidBottomInset: false,
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return InkWell(
      child: Container(
        width: 150,
        height: 150,
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
                offset: const Offset(10, 20),
                blurRadius: 10,
                spreadRadius: 5,
                color: Colors.grey.withOpacity(1)),
          ],
        ),
        child: Column(
          children: [
            Image.network(imageUrl, height: 70, fit: BoxFit.cover),
            Spacer(),
            Text("${trabajadores[index]["name"]}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              "${trabajadores[index]["phone"]}",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                  fontSize: 12),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      onTap: () {
        
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) =>
                    Contratar(info_trabajador: trabajadores[index]))));
      },
    );
  }
}
