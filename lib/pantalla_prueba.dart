import 'package:flutter/material.dart';

class pantalla_prueba extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'nueva pagina',
        ),
        backgroundColor: Color.fromARGB(249, 11, 236, 112),
      ),
      body: Center(
        child: Text(
          'Se cambio de pagina',
        ),
      ),
    );
  }
}
