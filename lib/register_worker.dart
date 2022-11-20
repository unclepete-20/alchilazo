import 'package:alchilazo/mongo.dart';
import 'package:alchilazo/pantalla_home.dart';
import 'package:alchilazo/services_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:flutter/material.dart';
import 'MongoDbModel_Worker.dart';
import 'dart:async';
import 'package:location/location.dart';

var lista_trabajos = [];
var lati, long = 0.0;

class RegisterWorker extends StatefulWidget {
  const RegisterWorker({Key? key, required this.name, required this.correo})
      : super(key: key);
  final String name;
  final String correo;

  @override
  State<RegisterWorker> createState() => _MyRegisterWorkerState();
}

class _MyRegisterWorkerState extends State<RegisterWorker> {
  int _activeStepIndex = 0;

  var address = TextEditingController();
  var phone = TextEditingController();
  var email = TextEditingController();
  var descripcion = TextEditingController();
  var foto_dpi = TextEditingController();
  var antecedente_penal = TextEditingController();
  var foto_perfil = TextEditingController();

  Future<void> _insertData(
    String name,
    String address,
    String phone,
    String email,
    String descripcion,
    String foto_dpi,
    String antecedente_penal,
    String foto_perfil,
  ) async {
    var _id = M.ObjectId();
    final data = MongoDbModel_Worker(
      id: _id,
      name: name,
      address: address,
      phone: phone,
      email: email,
      descripcion: descripcion,
      foto_dpi: foto_dpi,
      antecedente_penal: antecedente_penal,
      foto_perfil: foto_perfil,
      lista_trabajos: lista_trabajos,
      latitud: lati,
      longitud: long,
    );
    var result = await MongoDatabase.insert_worker(data);
    _clearAll();
  }

  List<Step> stepList() => [
        Step(
            state:
                _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex >= 0,
            title: const Text('Datos'),
            content: Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  key: const Key("dirrecion"),
                  controller: address,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Dirección fiscal'),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  key: const Key("phone"),
                  controller: phone,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Número telefónico'),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  key: const Key("description"),
                  controller: descripcion,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Descripcion del Trabajo que Realiza'),
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            )),
        Step(
            state:
                _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex >= 1,
            title: const Text('Subir Documentos'),
            content: Column(
              children: [
                TextField(
                  key: const Key("perfil"),
                  controller: foto_perfil,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Foto perfil'),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  key: const Key("antecedentes"),
                  controller: antecedente_penal,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: ' Foto Antecedentes Penales'),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  key: const Key("dpiPhoto"),
                  controller: foto_dpi,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Foto DPI'),
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            )),
        Step(
            state:
                _activeStepIndex <= 2 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex >= 2,
            title: const Text('Elegir Servicios Para Trabajar'),
            content: Column(
              key: const Key("trabajos"),
              children: [
                Card(
                    "Electricista",
                    "https://www.lecciona.com/wp-content/uploads/2020/11/ELECTRICISTA.jpg",
                    ""),
                Card(
                    "Jardineria",
                    "https://media.istockphoto.com/photos/garden-worker-trimming-plants-picture-id1166203849?k=20&m=1166203849&s=612x612&w=0&h=UVoI3c9o4DljCFxpRpJznJE5zONRgo9sxeyysO7xVZw=",
                    ""),
                Card(
                    "Plomeria",
                    "https://www.albaniles.org/wp-content/uploads/2016/08/plomero1-1024x713.jpg",
                    ""),
                Card(
                    "Albañileria",
                    "https://thumbs.dreamstime.com/b/alba%C3%B1iler%C3%ADa-118881926.jpg",
                    ""),
                Card(
                    "Carpinteria",
                    "https://ace-australia.com/wp-content/uploads/2021/09/Carpentry-1500x1000.webp",
                    ""),
                Card(
                    "Cerrajeria",
                    "https://www.cerrajeriaelhuron.com/uploads/PfYEdhSC/737x0_540x0/persona-instalando-chapa.jpg",
                    ""),
                Card(
                    "Computación",
                    "https://sotein.com.co/wp-content/uploads/2019/04/Arreglo-de-computadoras-1.jpg",
                    "Servicio"),
                Card(
                    "Pintura",
                    "https://www.reformas-baratas.es/wp-content/uploads/2018/04/pintar.jpg",
                    "Servicio"),
              ],
            )),
        Step(
          state: _activeStepIndex <= 3 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 3,
          title: const Text('Ubicacion'),
          content: Center(
            child: Container(
              width: 400.0,
              height: 500.0,
              padding: const EdgeInsets.all(20.0),
              child: MapScreen(),
            ),
          ),
        ),
        Step(
            state: StepState.complete,
            isActive: _activeStepIndex >= 4,
            title: const Text('Confirmar'),
            content: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Dirección Fiscal: ${address.text}'),
                  Text('Número telefónico: ${phone.text}'),
                  Text('Descripcion: ${descripcion.text}'),
                  Text('Foto_perfil: ${foto_perfil.text}'),
                  Text('Foto Antecedente penales: ${antecedente_penal.text}'),
                  Text('Foto DPI: ${foto_dpi.text}'),
                  Text('latitud: $lati'),
                  Text('longitud: $long'),
                ],
              ),
            ))
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Center(
            child: Text('Registro Trabajador'),
          ),
          backgroundColor: Color.fromRGBO(245, 71, 72, 1)),
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: _activeStepIndex,
        steps: stepList(),
        onStepContinue: () {
          if (_activeStepIndex < (stepList().length - 1)) {
            _activeStepIndex += 1;
            setState(() {});
          } else {
            _insertData(
                widget.name,
                address.text,
                phone.text,
                widget.correo,
                descripcion.text,
                foto_dpi.text,
                antecedente_penal.text,
                foto_perfil.text);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        HomePage(name: widget.name, correo: widget.correo)));
          }
        },
        onStepCancel: () {
          if (_activeStepIndex == 0) {
            return;
          }
          _activeStepIndex -= 1;
          setState(() {});
        },
        controlsBuilder: (BuildContext context, ControlsDetails details) {
          return Row(
            children: <Widget>[
              ElevatedButton(
                key: const Key("continue"),
                onPressed: details.onStepContinue,
                child: const Text("Continue"),
              ),
              ElevatedButton(
                onPressed: details.onStepCancel,
                child: const Text("Cancel"),
              ),
            ],
          );
        },
      ),
    );
  }

  void _clearAll() {
    address.text = '';
    phone.text = '';
    descripcion.text = '';
    foto_dpi.text = '';
    antecedente_penal.text = '';
    foto_perfil.text = '';
  }
}

class Card extends StatelessWidget {
  final String text;
  final String imageUrl;
  final String subtitle;

  Card(this.text, this.imageUrl, this.subtitle, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, bottom: 15),
      child: new InkWell(
        onTap: () {
          if (!lista_trabajos.contains(text)) {
            lista_trabajos.add(text);
          }
        },
        child: Container(
          width: 150,
          height: 150,
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.5),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(10, 20),
                  blurRadius: 10,
                  spreadRadius: 0,
                  color: Colors.grey.withOpacity(.05)),
            ],
          ),
          child: Column(
            children: [
              Image.network(imageUrl, height: 70, fit: BoxFit.cover),
              Spacer(),
              Text(text,
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
                subtitle,
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
      ),
    );
  }
}

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // GoogleMapController? mapController; //contrller for Google map
  Set<Marker> markers = Set(); //markers for google map

  LatLng showLocation = LatLng(14.569500, -90.559613);
  late GoogleMapController _controller;
  Location _location = Location();

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
    _location.onLocationChanged.listen((l) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(lati = l.latitude!, long = l.longitude!),
              zoom: 15),
        ),
      );
    });
  }

  @override
  void initState() {
    markers.add(Marker(
      //add marker on google map para mostrar posiciones que ya esten en la base de datos
      markerId: MarkerId(showLocation.toString()),
      position: showLocation, //position of marker
      infoWindow: InfoWindow(
        //popup info
        title: 'My Custom Title ',
        snippet: 'My Custom Subtitle',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));

    //you can add more markers here
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Localizacion"),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              GoogleMap(
                //Map widget from google_maps_flutter package
                zoomGesturesEnabled: true, //enable Zoom in, out on map
                initialCameraPosition: CameraPosition(
                  //innital position in map
                  target: showLocation, //initial position
                ),
                markers: markers, //markers to show on map
                mapType: MapType.normal, //map type
                onMapCreated: _onMapCreated,
                myLocationEnabled: true,
              ),
            ],
          ),
        ));
  }
}
