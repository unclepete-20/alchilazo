import 'package:alchilazo/pantalla_home.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:alchilazo/mongo.dart';
import 'MongoDbModel_User.dart';

class Registro extends StatefulWidget {
  static String id = 'registro_usuario';

  @override
  State<Registro> createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  //uso para obtener los datos ingreados para subirlo luego a la base de datos
  var name = new TextEditingController();
  var email = new TextEditingController();
  var pass = new TextEditingController();
  var dpi = new TextEditingController();
  var arrData = [];
  var existe = true;
  //lista con nombres
  List<String> usuario_existentes = [];

  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
        name.clear();
        email.clear();
        pass.clear();
        dpi.clear();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Correo registrado anteriormente"),
      content: Text("Este correo ya esta registrado con otro usuario."),
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
        email.clear();
        pass.clear();
        dpi.clear();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Casillas vacias"),
      content: Text("Llene todas las casillas."),
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
    for (var x = 0; x < arrData.length; x++) {
      usuario_existentes.add(arrData[x]['correo'].toString());
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
                      "Registro",
                      style: TextStyle(
                        color: Color.fromRGBO(25, 1, 1, 1),
                        fontSize: 40,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    _nameTextField(),
                    const SizedBox(
                      height: 20,
                    ),
                    _dpiTextField(),
                    const SizedBox(
                      height: 20,
                    ),
                    _emailTextField(),
                    const SizedBox(
                      height: 20,
                    ),
                    _passwordTextField(),
                    const SizedBox(
                      height: 50,
                    ),
                    _buttonRegistrar(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    )));
  }

  Future<void> _insertData(
      String name, String email, String pass, String dpi) async {
    var _id = M.ObjectId();
    final data = MongoDbModel_User(
        id: _id, nombre: name, correo: email, password: pass, dpi: dpi);
    var result = await MongoDatabase.insert_usuario(data);
    _clearAll();
  }

  Widget _nameTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: TextField(
          key: const Key("UserName"),
          controller: name,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.grey[200],
            prefixIcon: const Icon(Icons.abc),
            hintText: 'Ejemplo: Juan/Juana',
            labelText: 'Nombre',
          ),
          //Variable que recibirá el correo
          onChanged: (value) {},
        ),
      );
    });
  }

  Widget _emailTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: TextField(
          key: const Key("correo"),
          controller: email,
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
    });
  }

  Widget _passwordTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: TextField(
          key: const Key("contrasena"),
          controller: pass,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.grey[200],
            prefixIcon: Icon(Icons.lock),
            hintText: 'Ejemplo: 123456',
            labelText: 'Contraseña',
          ),
          //Variable que recibirá el correo
          onChanged: (value) {},
        ),
      );
    });
  }

  Widget _dpiTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: TextField(
          key: const Key("dpi"),
          controller: dpi,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.grey[200],
            prefixIcon: const Icon(Icons.account_circle),
            hintText: 'Ejemplo: 123456789',
            labelText: 'DPI',
          ),
          //Variable que recibirá el correo
          onChanged: (value) {},
        ),
      );
    });
  }

  Widget _buttonRegistrar() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return ElevatedButton(
        key: const Key("newUser"),
        child: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 118.0, vertical: 25.0),
          child: const Text('Registrar'),
        ),
        style: ElevatedButton.styleFrom(
          primary: const Color.fromRGBO(245, 71, 72, 1),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        onPressed: () {
          if (name.text.isNotEmpty &&
              email.text.isNotEmpty &&
              pass.text.isNotEmpty &&
              dpi.text.isNotEmpty) {
            for (var i = 0; i < usuario_existentes.length; i++) {
              if (email.text == usuario_existentes[i]) {
                print("Este usuario ya existe");
                existe = false;
              }
            }
            if (existe == true) {
              _insertData(name.text, email.text, pass.text, dpi.text);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(
                    name: name.text,
                    correo: email.text,
                  ),
                ),
              );
            } else {
              showAlertDialog(context);
            }
          } else {
            showAlertDialogTextEmpty(context);
          }
        },
      );
    });
  }

  void _clearAll() {
    name.text = '';
    email.text = '';
    pass.text = '';
    dpi.text = '';
  }
}
