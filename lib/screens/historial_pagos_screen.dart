import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../services/session.dart';

class HistorialPagosScreen extends StatefulWidget {
  const HistorialPagosScreen({super.key});

  @override
  State<HistorialPagosScreen> createState() =>
      _HistorialPagosScreenState();
}

class _HistorialPagosScreenState
    extends State<HistorialPagosScreen> {

  late Future<List<dynamic>> pagos;

  @override
  void initState() {
    super.initState();


    pagos =
    ApiService.obtenerHistorialPagos(
    Session.usuarioId!,
    );


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

    "Historial de Pagos",

    style: TextStyle(
    color: Colors.white,
    ),

    ),

    ),

    body: FutureBuilder<List<dynamic>>(

    future: pagos,

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

    "No hay pagos registrados",

    style: TextStyle(
    fontSize: 18,
    ),

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

    final pago =
    snapshot.data![index];

    return Card(

    elevation: 5,

    margin:
    const EdgeInsets.only(
    bottom: 15,
    ),

    shape:
    RoundedRectangleBorder(

    borderRadius:
    BorderRadius.circular(
    20,
    ),

    ),

    child: ListTile(

    contentPadding:
    const EdgeInsets.all(
    15,
    ),

    leading:
    const CircleAvatar(

    backgroundColor:
    Colors.green,

    child: Icon(

    Icons.payment,

    color:
    Colors.white,

    ),

    ),

    title: Text(

    pago["titulo"],

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
    "Método: ${pago["metodo_pago"]}",
    ),

    Text(
    "Monto: S/ ${pago["monto"]}",
    ),

    Text(
    pago["fecha_pago"],
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
