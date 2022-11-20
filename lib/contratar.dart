// ignore_for_file: prefer_const_constructors, duplicate_ignore, prefer_const_literals_to_create_immutables
import 'package:alchilazo/mongo.dart';
import 'package:alchilazo/solicitud_servicio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

double lati = 0.0;
double long = 0.0;

class Contratar extends StatefulWidget {
  const Contratar({Key? key, required this.info_trabajador}) : super(key: key);
  final info_trabajador;

  @override
  State<Contratar> createState() => _Contratar();
}

class _Contratar extends State<Contratar> {
  @override
  Widget build(BuildContext context) {
    lati = widget.info_trabajador["latitud"];
    long = widget.info_trabajador["longitud"];
    return Scaffold(
      //Main widget
      appBar: AppBar(
        title: Text('Contratar Trabajador'),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(245, 71, 72, 1),
      ),
      // ignore: prefer_const_constructors
      body: ListView(
        padding:
            EdgeInsets.only(top: 20.0, bottom: 10.0, left: 10.0, right: 10.0),
        children: <Widget>[
          Text(
            'Datos',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Nombre: ${widget.info_trabajador["name"]}",
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Telefono: ${widget.info_trabajador["phone"]}",
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Direccion: ${widget.info_trabajador["address"]}",
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              '\nFoto de perfil:\n',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Image.network(
              "https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png"),
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
            margin: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              border: Border.all(color: Color.fromARGB(0, 0, 0, 0)),
              shape: BoxShape.rectangle,
            ),
            child: Text("${widget.info_trabajador["descripcion"]}"),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              '\Ubicacion:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Container(
            child: Container(
              width: 400.0,
              height: 500.0,
              padding: const EdgeInsets.all(20.0),
              child: MapScreen(),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                builder: ((context) =>
                    Solicitud(info_trabajador: widget.info_trabajador))));
              },
              style: ElevatedButton.styleFrom(primary: Colors.red),
              child: Text(
                'Contratar',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ],
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

  LatLng showLocation = LatLng(lati, long);
  late GoogleMapController _controller;
  Location _location = Location();

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
    _location.onLocationChanged.listen((l) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(
                l.latitude!,
                l.longitude!,
              ),
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
