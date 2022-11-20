import 'package:alchilazo/registro_usuario.dart';
import 'package:flutter/material.dart';
import 'ingreso_sesion.dart';

class LoginPage extends StatefulWidget {
  static String id = 'login_page';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Navigator.canPop(context);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 80.0,
              ),
              Image.asset(
                'images/logo-chile.png',
                height: 250.0,
              ),
              const SizedBox(
                height: 110.0,
              ),
              _bottonLogin(),
              const SizedBox(
                height: 40.0,
              ),
              _buttonRegister()
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottonLogin() {
    return ElevatedButton(
        key: const Key("loginbutton"),
        child: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 100.0, vertical: 28.0),
          child: const Text('Iniciar Sesión'),
        ),
        style: ElevatedButton.styleFrom(
          primary: const Color.fromRGBO(245, 71, 72, 1),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Ingreso()));
        });
  }

  Widget _buttonRegister() {
    return ElevatedButton(
        key: const Key("registerbutton"),
        child: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 100.0, vertical: 28.0),
          child: const Text('Registrarse'),
        ),
        style: ElevatedButton.styleFrom(
          primary: const Color.fromRGBO(245, 71, 72, 1),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Registro()));
        });
  }
}
