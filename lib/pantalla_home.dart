import 'package:alchilazo/mongo.dart';
import 'package:alchilazo/register_worker.dart';
import 'package:alchilazo/services_screen.dart';
import 'package:alchilazo/worker_services.dart';
import 'package:flutter/material.dart';

// class HomePage_material extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: HomePage(
//         correo: 'par20117@uvg.edu.gt',
//         name: 'yong',
//       ),
//     );
//   }
// }

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.name, required this.correo})
      : super(key: key);
  @override
  final String name;
  final String correo;
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  var arrData = [];
  //lista con nombres
  List<String> personal_servicio = [];
  List<String> usuario_existentes = [];

  Future _getData() async {
    arrData = await MongoDatabase.getData_workers();
    for (var x = 0; x < arrData.length; x++) {
      personal_servicio.add(arrData[x]['name'].toString());
      usuario_existentes.add(arrData[x]['email'].toString());
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(245, 249, 249, 249),
      appBar: AppBar(
          title: Text("Al Chilazo"),
          backgroundColor: Color.fromRGBO(245, 71, 72, 1)),
      body: Column(
        children: [
          Text(
            "Bienvenido, ${widget.name}",
            style: TextStyle(fontSize: 20),
          ),
          Divider(
            color: Colors.black,
          ),
          //boton para ir a llenar para ofrecer servicios
          ElevatedButton(
            key: const Key("Trabajador"),
            child: Text('Sección de Trabajador'),
            onPressed: () {
              var trabajador_existe = null;
              for (var i = 0; i < usuario_existentes.length; i++) {
                print(usuario_existentes[i]);
                if (widget.correo == usuario_existentes[i]) {
                  trabajador_existe = widget.correo;
                }
              }
              if (trabajador_existe != null) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Servicios_Trabajador()));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegisterWorker(
                            name: widget.name, correo: widget.correo)));
              }
            },
            style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 255, 79, 66),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
          ),
          Divider(
            color: Colors.black,
          ),
          //muestra todos las personas disponibles que ofrecen servicios
          Text(
            'Trabajadores que existen',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 15.0, bottom: 15.0),
            height: 90,
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: personal_servicio.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Center(
                      child: Text(
                    personal_servicio[index],
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
          Divider(
            color: Colors.black,
          ),
          //boton para buscar servicios
          ElevatedButton(
            key: const Key("SearchService"),
            child: Text('Buscar Servicios'),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ServicesScreen(correo: widget.correo)));
            },
            style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 255, 79, 66),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
          ),
        ],
      ),
    );
  }
}
