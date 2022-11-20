import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  //primer flujo
  group(
    'Primer flujo, ingresar y comenzar busqueda de trabajador',
    () {
      final loginbutton = find.byValueKey("loginbutton");
      final userlogin = find.byValueKey("usuario");
      final passlogin = find.byValueKey("contrasena");
      final verifybutton = find.byValueKey("verifyUser");
      final searchService = find.byValueKey("SearchService");

      late FlutterDriver driver;

      //conectarlo al flutter driver antes de realizar las pruebas
      setUpAll(() async {
        driver = await FlutterDriver.connect();
      });

      //cerrar conexion al terminar las pruebas
      tearDownAll(() async {
        if (driver != null) {
          driver.screenshot();
        }
      });

      test("presionar login button", () async {
        await Future.delayed(const Duration(seconds: 2));
        driver.tap(loginbutton);
      });

      test("llenar datos para ingresar", () async {
        await driver.tap(userlogin);
        await driver.enterText("par20117@uvg.edu.gt");
        await driver.waitFor(find.text('par20117@uvg.edu.gt'));
        await driver.tap(passlogin);
        await driver.enterText("123456");
        await Future.delayed(const Duration(seconds: 2));
      });

      test("Ingresar a la aplicacion", () {
        driver.tap(verifybutton);
        driver.tap(verifybutton);
      });

      test("Buscar un servicio", () async {
        await Future.delayed(const Duration(seconds: 2));
        driver.tap(searchService);
      });
    },
  );

  //segundo flujo
  // group(
  //   'Segundo flujo, Ingresar como un nuevo usuario',
  //   () {
  //     final registerbutton = find.byValueKey("registerbutton");
  //     final username = find.byValueKey("UserName");
  //     final email = find.byValueKey("correo");
  //     final password = find.byValueKey("contrasena");
  //     final dpi = find.byValueKey("dpi");
  //     final newUserButton = find.byValueKey("newUser");

  //     late FlutterDriver driver;

  //     //conectarlo al flutter driver antes de realizar las pruebas
  //     setUpAll(() async {
  //       driver = await FlutterDriver.connect();
  //     });

  //     //cerrar conexion al terminar las pruebas
  //     tearDownAll(() async {
  //       if (driver != null) {
  //         driver.screenshot();
  //       }
  //     });

  //     test("presionar registrar button", () async {
  //       await Future.delayed(const Duration(seconds: 2));
  //       driver.tap(registerbutton);
  //     });

  //     test("llenar datos para registrarse como un nuevo usuario", () async {
  //       await driver.tap(username);
  //       await driver.enterText("test");
  //       await driver.waitFor(find.text('test'));
  //       await driver.tap(email);
  //       await driver.enterText("test@gmail.com");
  //       await driver.waitFor(find.text('test@gmail.com'));
  //       await driver.tap(password);
  //       await driver.enterText("123");
  //       await driver.tap(dpi);
  //       await driver.enterText("55123456789");
  //       await driver.waitFor(find.text('55123456789'));
  //       await Future.delayed(const Duration(seconds: 2));
  //     });

  //     test("click en el boton para registrarse", () {
  //       driver.tap(newUserButton);
  //     });
  //   },
  // );

  //tercer flujo
  // group(
  //   'Tercer flujo, ingresar y registrarse como un nuevo trabajador',
  //   () {
  //     final loginbutton = find.byValueKey("loginbutton");
  //     final userlogin = find.byValueKey("usuario");
  //     final passlogin = find.byValueKey("contrasena");
  //     final verifybutton = find.byValueKey("verifyUser");
  //     final workerRegister = find.byValueKey("Trabajador");

  //     final direction = find.byValueKey("dirrecion");
  //     final phone = find.byValueKey("phone");
  //     final description = find.byValueKey("description");
  //     final perfil = find.byValueKey("perfil");
  //     final antecedentes = find.byValueKey("antecedentes");
  //     final dpiPhoto = find.byValueKey("dpiPhoto");
  //     final continueButton = find.byValueKey("continue");

  //     late FlutterDriver driver;

  //     //conectarlo al flutter driver antes de realizar las pruebas
  //     setUpAll(() async {
  //       driver = await FlutterDriver.connect();
  //     });

  //     //cerrar conexion al terminar las pruebas
  //     tearDownAll(() async {
  //       if (driver != null) {
  //         driver.screenshot();
  //       }
  //     });

  //     test("presionar login button", () async {
  //       await Future.delayed(const Duration(seconds: 2));
  //       driver.tap(loginbutton);
  //     });

  //     test("llenar datos para ingresar", () async {
  //       await driver.tap(userlogin);
  //       await driver.enterText("test@gmail.com");
  //       await driver.waitFor(find.text('test@gmail.com'));
  //       await driver.tap(passlogin);
  //       await driver.enterText("123");
  //       await Future.delayed(const Duration(seconds: 2));
  //     });

  //     test("Ingresar a la aplicacion", () {
  //       driver.tap(verifybutton);
  //       driver.tap(verifybutton);
  //     });

  //     test("Darle click para registrarse como un trabajador nuevo", () async {
  //       await Future.delayed(const Duration(seconds: 2));
  //       driver.tap(workerRegister);
  //     });

  //     test("llenar datos de la primera parte", () async {
  //       await driver.tap(direction);
  //       await driver.enterText("12-53 united states");
  //       await driver.waitFor(find.text('12-53 united states'));
  //       await driver.tap(phone);
  //       await driver.enterText("11111111");
  //       await driver.waitFor(find.text('11111111'));
  //       await driver.tap(description);
  //       await driver.enterText("Programmer");
  //       await driver.waitFor(find.text('Programmer'));
  //       await Future.delayed(const Duration(seconds: 2));
  //     });

  //     test("Continue button press para el primero", () {
  //       driver.tap(continueButton);
  //     });

  //     test("llenar datos de la segunda parte", () async {
  //       await driver.tap(perfil);
  //       await driver.enterText("00000");
  //       await driver.waitFor(find.text("00000"));
  //       await driver.tap(antecedentes);
  //       await driver.enterText("00000");
  //       await driver.waitFor(find.text('00000'));
  //       await driver.tap(dpiPhoto);
  //       await driver.enterText("00000");
  //       await driver.waitFor(find.text('00000'));
  //       await Future.delayed(const Duration(seconds: 2));
  //     });

  //     test("Continue button press para el segundo", () async {
  //       driver.tap(continueButton);
  //     });

  //     test("Continue button press para el tercero", () async {
  //       await Future.delayed(const Duration(seconds: 2));
  //       driver.tap(continueButton);
  //     });

  //     test("Continue button press para el cuarto", () async {
  //       await Future.delayed(const Duration(seconds: 2));
  //       driver.tap(continueButton);
  //     });

  //     test("Continue button press para el ultimo", () async {
  //       await Future.delayed(const Duration(seconds: 2));
  //       driver.tap(continueButton);
  //     });
  //   },
  // );
}
