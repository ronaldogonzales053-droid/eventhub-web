import 'package:flutter/material.dart';
import '../models/evento.dart';
import '../services/api_service.dart';
import '../services/session.dart';

import 'login_screen.dart';
import 'mis_reservas_screen.dart';
import 'admin_screen.dart';
import 'pago_screen.dart';
import 'historial_pagos_screen.dart';

class EventosScreen extends StatefulWidget {

  const EventosScreen({super.key});

  @override
  State<EventosScreen> createState() =>
      _EventosScreenState();

}

class _EventosScreenState
    extends State<EventosScreen> {

late Future<List<Evento>> eventos;

@override
void initState() {


super.initState();

eventos =
ApiService().obtenerEventos();


}

Future<void> recargarEventos() async {


setState(() {

eventos =
ApiService().obtenerEventos();

});


}

@override
Widget build(BuildContext context) {


return Scaffold(

backgroundColor:
const Color(0xFFF4F5F7),

appBar: AppBar(

backgroundColor:
Colors.deepPurple,

title: const Text(

"EventHub",

style: TextStyle(
color: Colors.white,
fontWeight: FontWeight.bold,
),

),

actions: [

IconButton(

icon: const Icon(
Icons.receipt_long,
color: Colors.white,
),

onPressed: () {

Navigator.push(

context,

MaterialPageRoute(

builder: (_) =>
const HistorialPagosScreen(),

),

);

},

),

IconButton(

icon: const Icon(
Icons.bookmark,
color: Colors.white,
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

if(Session.esAdmin)

IconButton(

icon: const Icon(
Icons.admin_panel_settings,
color: Colors.white,
),

onPressed: () {

Navigator.push(

context,

MaterialPageRoute(

builder: (_) =>
const AdminScreen(),

),

);

},

),

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

body: RefreshIndicator(

onRefresh: recargarEventos,

child: FutureBuilder<List<Evento>>(

future: eventos,

builder: (context,snapshot){

if(snapshot.connectionState ==
ConnectionState.waiting){

return const Center(
child:
CircularProgressIndicator(),
);

}

if(!snapshot.hasData ||
snapshot.data!.isEmpty){

return const Center(

child: Text(
"No hay eventos disponibles",
),

);

}

return Column(

children: [

Container(

width: double.infinity,

margin:
const EdgeInsets.all(15),

padding:
const EdgeInsets.all(20),

decoration: BoxDecoration(

gradient:
const LinearGradient(

colors: [

Colors.deepPurple,
Color(0xFF9C27B0),

],

),

borderRadius:
BorderRadius.circular(
20,
),

),

child: Column(

crossAxisAlignment:
CrossAxisAlignment.start,

children: [

Text(

"Hola ${Session.nombre}",

style: const TextStyle(

color: Colors.white,

fontSize: 22,

fontWeight:
FontWeight.bold,

),

),

const SizedBox(
height: 8,
),

const Text(

"Encuentra los mejores eventos del momento",

style: TextStyle(
color:
Colors.white70,
),

),

],

),

),

Expanded(
child: ListView.builder(

  padding:
  const EdgeInsets.all(15),

  itemCount:
  snapshot.data!.length,

  itemBuilder:
  (context,index){


  final evento =
  snapshot.data![index];

  return Card(

  elevation: 5,

  margin:
  const EdgeInsets.only(
  bottom: 20,
  ),

  shape:
  RoundedRectangleBorder(

  borderRadius:
  BorderRadius.circular(
  25,
  ),

  ),

  child: Column(

  crossAxisAlignment:
  CrossAxisAlignment.start,

  children: [

  ClipRRect(

  borderRadius:
  const BorderRadius.only(

  topLeft:
  Radius.circular(25),

  topRight:
  Radius.circular(25),

  ),

  child: Image.network(

  evento.imagen,

  height: 240,

  width:
  double.infinity,

  fit: BoxFit.cover,

  errorBuilder:
  (context,error,stackTrace){

  return Image.network(

  "https://picsum.photos/800/400",

  height: 240,

  width:
  double.infinity,

  fit: BoxFit.cover,

  );

  },

  ),

  ),

  Padding(

  padding:
  const EdgeInsets.all(18),

  child: Column(

  crossAxisAlignment:
  CrossAxisAlignment.start,

  children: [

  Text(

  evento.titulo,

  style:
  const TextStyle(

  fontSize: 24,

  fontWeight:
  FontWeight.bold,

  ),

  ),

  const SizedBox(
  height: 10,
  ),

  Text(
  evento.descripcion,
  ),

  const SizedBox(
  height: 15,
  ),

  Row(

  children: [

  const Icon(
  Icons.calendar_month,
  color:
  Colors.deepPurple,
  ),

  const SizedBox(
  width: 8,
  ),

  Text(
  evento.fechaEvento,
  ),

  ],

  ),

  const SizedBox(
  height: 10,
  ),

  Row(

  children: [

  const Icon(
  Icons.location_on,
  color: Colors.red,
  ),

  const SizedBox(
  width: 8,
  ),

  Expanded(

  child: Text(
  evento.ubicacion,
  ),

  ),

  ],

  ),

  const SizedBox(
  height: 15,
  ),

  Container(

  padding:
  const EdgeInsets.all(
  12,
  ),

  decoration:
  BoxDecoration(

  color:
  Colors.green.shade50,

  borderRadius:
  BorderRadius.circular(
  15,
  ),

  ),

  child: const Row(

  children: [

  Icon(
  Icons.sell,
  color:
  Colors.green,
  ),

  SizedBox(
  width: 8,
  ),

  Text(

  "Precio: S/ 50.00",

  style: TextStyle(

  fontWeight:
  FontWeight.bold,

  fontSize: 18,

  color:
  Colors.green,

  ),

  ),

  ],

  ),

  ),

  const SizedBox(
  height: 20,
  ),

  SizedBox(

  width:
  double.infinity,

  child:
  ElevatedButton.icon(

  style:
  ElevatedButton.styleFrom(

  backgroundColor:
  Colors.deepPurple,

  padding:
  const EdgeInsets.symmetric(
  vertical: 15,
  ),

  ),

  onPressed: () {

  Navigator.push(

  context,

  MaterialPageRoute(

  builder: (_) =>
  PagoScreen(

  eventoId:
  evento.id,

  titulo:
  evento.titulo,

  precio:
  50.0,

  ),

  ),

  );

  },

  icon: const Icon(
  Icons.payment,
  color: Colors.white,
  ),

  label: const Text(

  "Comprar Entrada",

  style: TextStyle(

  color: Colors.white,

  fontWeight:
  FontWeight.bold,

  ),

  ),

  ),

  ),

  ],

  ),

  ),

  ],

  ),

  );

  },

  ),

  ),

  ],

  );

  },

  ),

  ),

  );

}

}
