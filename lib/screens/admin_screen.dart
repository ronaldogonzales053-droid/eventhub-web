import 'package:flutter/material.dart';
import '../services/session.dart';
import 'crear_evento_screen.dart';
import 'gestion_eventos_screen.dart';
import 'mis_reservas_screen.dart';
import 'login_screen.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {


    return Scaffold(

    backgroundColor: const Color(0xFFF4F5F7),

    appBar: AppBar(

    backgroundColor: Colors.deepPurple,

    title: const Text(
    "Panel Administrador",
    style: TextStyle(
    color: Colors.white,
    ),
    ),

    actions: [

    IconButton(

    icon: const Icon(
    Icons.logout,
    color: Colors.white,
    ),

    onPressed: () {

    Session.cerrarSesion();

    Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
    builder: (_) =>
    const LoginScreen(),
    ),
    (route) => false,
    );
    },
    ),
    ],
    ),

    body: SingleChildScrollView(

    padding: const EdgeInsets.all(20),

    child: Column(

    children: [

    const SizedBox(height: 20),

    const CircleAvatar(

    radius: 55,

    backgroundColor:
    Colors.deepPurple,

    child: Icon(
    Icons.admin_panel_settings,
    size: 60,
    color: Colors.white,
    ),
    ),

    const SizedBox(height: 15),

    Text(
    "Bienvenido ${Session.nombre ?? "Administrador"}",
    style: const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    ),
    ),

    const SizedBox(height: 5),

    const Text(
    "Panel de Control EventHub",
    style: TextStyle(
    color: Colors.grey,
    ),
    ),

    const SizedBox(height: 35),

    SizedBox(

    width: double.infinity,
    height: 60,

    child: ElevatedButton.icon(

    icon: const Icon(Icons.add),

    label: const Text(
    "Crear Evento",
    ),

    style:
    ElevatedButton.styleFrom(
    backgroundColor:
    Colors.green,
    ),

    onPressed: () {

    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (_) =>
    const CrearEventoScreen(),
    ),
    );
    },
    ),
    ),

    const SizedBox(height: 15),

    SizedBox(

    width: double.infinity,
    height: 60,

    child: ElevatedButton.icon(

    icon: const Icon(
    Icons.edit_calendar,
    ),

    label: const Text(
    "Gestionar Eventos",
    ),

    style:
    ElevatedButton.styleFrom(
    backgroundColor:
    Colors.orange,
    ),

    onPressed: () {

    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (_) =>
    const GestionEventosScreen(),
    ),
    );
    },
    ),
    ),

    const SizedBox(height: 15),

    SizedBox(

    width: double.infinity,
    height: 60,

    child: ElevatedButton.icon(

    icon: const Icon(
    Icons.bookmark,
    ),

    label: const Text(
    "Ver Reservas",
    ),

    style:
    ElevatedButton.styleFrom(
    backgroundColor:
    Colors.deepPurple,
    ),

    onPressed: () {

    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (_) =>
    const MisReservasScreen(),
    ),
    );
    },
    ),
    ),

    const SizedBox(height: 15),

    SizedBox(

    width: double.infinity,
    height: 60,

    child: ElevatedButton.icon(

    icon: const Icon(
    Icons.logout,
    ),

    label: const Text(
    "Cerrar Sesión",
    ),

    style:
    ElevatedButton.styleFrom(
    backgroundColor:
    Colors.red,
    ),

    onPressed: () {

    Session.cerrarSesion();

    Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
    builder: (_) =>
    const LoginScreen(),
    ),
    (route) => false,
    );
    },
    ),
    ),
    ],
    ),
    ),
    );


  }
}
