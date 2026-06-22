import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'editar_evento_screen.dart';

class GestionEventosScreen extends StatefulWidget {
  const GestionEventosScreen({super.key});

  @override
  State<GestionEventosScreen> createState() =>
      _GestionEventosScreenState();
}

class _GestionEventosScreenState
    extends State<GestionEventosScreen> {

  late Future<List<dynamic>> eventos;

  @override
  void initState() {
    super.initState();
    cargarEventos();
  }

  void cargarEventos() {


    eventos =
    ApiService.obtenerEventosAdmin();


  }

  void recargar() {


    setState(() {

    cargarEventos();

    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    backgroundColor:
    const Color(0xFFF4F5F7),

    appBar: AppBar(
    title: const Text(
    "Gestionar Eventos",
    ),
    backgroundColor:
    Colors.deepPurple,
    ),

    body: FutureBuilder<List<dynamic>>(

    future: eventos,

    builder:
    (context,snapshot){

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
    "No existen eventos",
    ),
    );
    }

    return ListView.builder(

    padding:
    const EdgeInsets.all(15),

    itemCount:
    snapshot.data!.length,

    itemBuilder:
    (context,index){

    final evento =
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
    evento["titulo"],
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
    height: 5,
    ),

    Text(
    evento[
    "descripcion"],
    ),

    const SizedBox(
    height: 5,
    ),

    Text(
    "📅 ${evento["fecha_evento"]}",
    ),

    Text(
    "📍 ${evento["ubicacion"]}",
    ),
    ],
    ),

    trailing: Row(

    mainAxisSize:
    MainAxisSize.min,

    children: [

    IconButton(

    icon: const Icon(
    Icons.edit,
    color:
    Colors.orange,
    ),

    onPressed: () {

    Navigator.push(

    context,

    MaterialPageRoute(

    builder: (_) =>
    EditarEventoScreen(
    evento:
    evento,
    ),

    ),

    ).then((value){

    recargar();

    });
    },
    ),

    IconButton(

    icon: const Icon(
    Icons.delete,
    color: Colors.red,
    ),

    onPressed:
    () async {

    final confirmar =
    await showDialog(

    context:
    context,

    builder:
    (_) {

    return AlertDialog(

    title:
    const Text(
    "Eliminar Evento",
    ),

    content:
    const Text(
    "¿Deseas eliminar este evento?",
    ),

    actions: [

    TextButton(

    onPressed:
    () {

    Navigator.pop(
    context,
    false,
    );

    },

    child:
    const Text(
    "Cancelar",
    ),
    ),

    ElevatedButton(

    onPressed:
    () {

    Navigator.pop(
    context,
    true,
    );

    },

    child:
    const Text(
    "Eliminar",
    ),
    ),
    ],
    );
    },
    );

    if(confirmar
    != true){
    return;
    }

    final result =
    await ApiService
        .eliminarEvento(

    int.parse(
    evento["id"]
        .toString(),
    ),
    );

    if(result[
    "success"] ==
    true){

    ScaffoldMessenger
        .of(context)
        .showSnackBar(

    const SnackBar(
    content: Text(
    "Evento eliminado",
    ),
    ),
    );

    recargar();
    }
    },
    ),
    ],
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
