import 'package:alchilazo/mongo.dart';
import 'package:alchilazo/pantalla_home.dart';
import 'package:flutter/material.dart';

class Ingreso_material extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Ingreso(),
    );
  }
}

class Ingreso extends StatefulWidget {
  static String id = 'ingreso_sesion';

  @override
  State<Ingreso> createState() => _IngresoState();
}

class _IngresoState extends State<Ingreso> {
  //uso para obtener los datos ingreados para subirlo luego a la base de datos
  var name = TextEditingController();
  var pass = TextEditingController();
  var arrData = [];
  var usuario = true;

  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
        name.clear();
        pass.clear();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Usuario o contraseña equivocada"),
      content: Text(
          "Asegure de escribir correctamente el usuario o la contraseña, o puede ser que no exista este usuario."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialogTextEmpty(BuildContext context) {
    // Create button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
        name.clear();
        pass.clear();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Casillas no estan llenas"),
      content: Text("Porfavor llene todas las casillas."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future _getData() async {
    arrData = await MongoDatabase.getData_users();
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
        body: SingleChildScrollView(
            child: Container(
      constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height,
          maxWidth: MediaQuery.of(context).size.width),
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromRGBO(245, 71, 72, 1),
          Color.fromRGBO(245, 71, 72, 20)
        ], begin: Alignment.topLeft, end: Alignment.centerRight),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 34.0, horizontal: 140.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'images/logo-chile.png',
                    width: 100,
                    height: 100,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Iniciar Sesión",
                      style: TextStyle(
                        color: Color.fromRGBO(25, 1, 1, 1),
                        fontSize: 40,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    _userTextField(),
                    const SizedBox(
                      height: 40,
                    ),
                    _userPassword(),
                    const SizedBox(
                      height: 40,
                    ),
                    _buttonLogin(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    )));
  }

  Widget _userTextField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextField(
        key: const Key('usuario'),
        controller: name,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[200],
          prefixIcon: const Icon(Icons.email),
          hintText: 'ejemplo@correo.com',
          labelText: 'Correo electronico',
        ),
        //Variable que recibirá el correo
        onChanged: (value) {},
      ),
    );
  }

  Widget _userPassword() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextField(
        key: const Key('contrasena'),
        controller: pass,
        keyboardType: TextInputType.emailAddress,
        obscureText: true,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[200],
          prefixIcon: const Icon(Icons.lock),
          hintText: 'password',
          labelText: 'Contraseña',
        ),
        //Variable que recibirá el correo
        onChanged: (value) {},
      ),
    );
  }

  Widget _buttonLogin() {
    return ElevatedButton(
      key: const Key("verifyUser"),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 25.0),
        child: const Text('Iniciar sesión'),
      ),
      style: ElevatedButton.styleFrom(
        primary: const Color.fromRGBO(245, 71, 72, 1),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w800,
        ),
      ),
      onPressed: () {
        _getData();
        if (name.text.isNotEmpty && pass.text.isNotEmpty) {
          for (var x = 0; x < arrData.length; x++) {
            if (name.text == arrData[x]['correo'].toString() &&
                pass.text == arrData[x]['password'].toString()) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePage(
                          name: arrData[x]['nombre'],
                          correo: arrData[x]['correo'])));
              break;
            }
          }
          if (usuario == false) {
            showAlertDialog(context);
          }
        } else {
          showAlertDialogTextEmpty(context);
        }
      },
    );
  }
}
