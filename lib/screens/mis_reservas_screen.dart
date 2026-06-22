import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../services/session.dart';
class MisReservasScreen extends StatefulWidget {
  const MisReservasScreen({super.key});

  @override
  State<MisReservasScreen> createState() =>
      _MisReservasScreenState();
}

class _MisReservasScreenState
    extends State<MisReservasScreen> {

  late Future<List<dynamic>> reservas;

  @override
  void initState() {
    super.initState();


    reservas =
    ApiService.obtenerMisReservas(
    Session.usuarioId!,
    );


  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(

    appBar: AppBar(
    title: const Text(
    "Mis Reservas",
    ),
    backgroundColor: Colors.deepPurple,
    ),

    body: FutureBuilder<List<dynamic>>(

    future: reservas,

    builder: (context, snapshot) {

    if(snapshot.connectionState ==
    ConnectionState.waiting){

    return const Center(
    child:
    CircularProgressIndicator(),
    );
    }

    if(snapshot.hasError){

    return Center(
    child: Text(
    snapshot.error.toString(),
    ),
    );
    }

    if(!snapshot.hasData ||
    snapshot.data!.isEmpty){

    return const Center(
    child: Text(
    "No tienes reservas registradas",
    style: TextStyle(
    fontSize: 18,
    ),
    ),
    );
    }

    return ListView.builder(

    padding:
    const EdgeInsets.all(10),

    itemCount:
    snapshot.data!.length,

    itemBuilder:
    (context,index){

    final reserva =
    snapshot.data![index];

    return Card(

    elevation: 4,

    margin:
    const EdgeInsets.only(
    bottom: 15,
    ),

    shape:
    RoundedRectangleBorder(
    borderRadius:
    BorderRadius.circular(
    15),
    ),

    child: ListTile(

    contentPadding:
    const EdgeInsets.all(
    15),

    leading:
    const CircleAvatar(
    backgroundColor:
    Colors.deepPurple,
    child: Icon(
    Icons.event,
    color:
    Colors.white,
    ),
    ),

    title: Text(
    reserva["titulo"],
    style:
    const TextStyle(
    fontWeight:
    FontWeight.bold,
    ),
    ),

    subtitle: Column(
    crossAxisAlignment:
    CrossAxisAlignment
        .start,
    children: [

    const SizedBox(
    height: 8,
    ),

    Text(
    reserva[
    "descripcion"] ??
    "",
    ),

    const SizedBox(
    height: 5,
    ),

    Text(
    "📅 ${reserva["fecha_evento"]}",
    ),

    Text(
    "📍 ${reserva["ubicacion"]}",
    ),
    ],
    ),

    trailing:
    IconButton(

    icon: const Icon(
    Icons.delete,
    color: Colors.red,
    ),

    onPressed:
    () async {

    final result =
    await ApiService.eliminarReserva(
      int.parse(reserva["id"].toString()),
    );

    if(result[
    "success"] ==
    true){

    ScaffoldMessenger
        .of(context)
        .showSnackBar(

    const SnackBar(
    content: Text(
    "Reserva cancelada",
    ),
    ),
    );

    setState(() {

    reservas =
    ApiService
        .obtenerMisReservas(
    Session
        .usuarioId!,
    );

    });

    }else{

    ScaffoldMessenger
        .of(context)
        .showSnackBar(

    SnackBar(
    content: Text(
    result["message"] ??
    "Error",
    ),
    ),
    );
    }
    },
    ),
    ),
    );
    },
    );
    },
    ),
    );

  }
}
