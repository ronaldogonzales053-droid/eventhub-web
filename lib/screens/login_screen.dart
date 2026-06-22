import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../services/session.dart';
import 'register_screen.dart';
import 'eventos_screen.dart';

class LoginScreen extends StatelessWidget {
const LoginScreen({super.key});

@override
Widget build(BuildContext context) {


final emailController =
TextEditingController();

final passwordController =
TextEditingController();

return Scaffold(

body: Container(

decoration: const BoxDecoration(
gradient: LinearGradient(
colors: [
Color(0xFF4A148C),
Color(0xFF7B1FA2),
],
begin: Alignment.topCenter,
end: Alignment.bottomCenter,
),
),

child: Center(

child: SingleChildScrollView(

child: Container(

width: 400,

padding:
const EdgeInsets.all(25),

margin:
const EdgeInsets.all(20),

decoration: BoxDecoration(
color: Colors.white,

borderRadius:
BorderRadius.circular(25),

boxShadow: const [
BoxShadow(
color: Colors.black12,
blurRadius: 15,
)
],
),

child: Column(
mainAxisSize:
MainAxisSize.min,

children: [

const Icon(
Icons.event_available,
size: 80,
color: Colors.deepPurple,
),

const SizedBox(height: 10),

const Text(
"EVENTHUB",
style: TextStyle(
fontSize: 30,
fontWeight:
FontWeight.bold,
),
),

const SizedBox(height: 5),

const Text(
"Inicia sesión para continuar",
style: TextStyle(
color: Colors.grey,
),
),

const SizedBox(height: 30),

TextField(

controller:
emailController,

decoration:
InputDecoration(

labelText:
"Correo",

prefixIcon:
const Icon(
Icons.email,
),

border:
OutlineInputBorder(
borderRadius:
BorderRadius.circular(
15),
),
),
),

const SizedBox(height: 15),

TextField(

controller:
passwordController,

obscureText: true,

decoration:
InputDecoration(

labelText:
"Contraseña",

prefixIcon:
const Icon(
Icons.lock,
),

border:
OutlineInputBorder(
borderRadius:
BorderRadius.circular(
15),
),
),
),

const SizedBox(height: 25),

  SizedBox(

  width: double.infinity,
  height: 55,

  child: ElevatedButton(

  onPressed: () async {

  final result =
  await ApiService.login(
  emailController.text,
  passwordController.text,
  );

  if(result["success"] == true){

  final usuario =
  result["usuario"];

  Session.guardarUsuario(

  int.parse(
  usuario["id"]
      .toString(),
  ),

  usuario["nombre"]
  ?? "",

  usuario["email"]
  ?? "",

  usuario["rol"]
  ?? "cliente",

  );

  ScaffoldMessenger.of(
  context)
      .showSnackBar(

  const SnackBar(
  content: Text(
  "Bienvenido a EventHub",
  ),
  ),
  );

  Navigator.pushReplacement(
  context,
  MaterialPageRoute(
  builder: (_) =>
  const EventosScreen(),
  ),
  );

  }else{

  ScaffoldMessenger.of(
  context)
      .showSnackBar(

  SnackBar(
  content: Text(
  result["message"] ??
  "Error de login",
  ),
  ),
  );
  }
  },

  style:
  ElevatedButton.styleFrom(

  backgroundColor:
  Colors.deepPurple,

  shape:
  RoundedRectangleBorder(
  borderRadius:
  BorderRadius.circular(
  15),
  ),
  ),

  child: const Text(
  "Iniciar Sesión",
  style: TextStyle(
  fontSize: 18,
  color: Colors.white,
  ),
  ),
  ),
  ),

  const SizedBox(height: 20),

  TextButton(

  onPressed: () {

  Navigator.push(
  context,
  MaterialPageRoute(
  builder: (_) =>
  const RegisterScreen(),
  ),
  );
  },

  child: const Text(
  "¿No tienes cuenta? Regístrate",
  ),
  ),
  ],
  ),
  ),
  ),
  ),
  ),
  );


}
}
