import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../services/session.dart';

class PagoScreen extends StatefulWidget {

  final int eventoId;
  final String titulo;
  final double precio;

  const PagoScreen({
    super.key,
    required this.eventoId,
    required this.titulo,
    required this.precio,
  });

  @override
  State<PagoScreen> createState() =>
      _PagoScreenState();
}

class _PagoScreenState
    extends State<PagoScreen> {

  String metodoPago = "Yape";

  @override
  Widget build(BuildContext context) {


    return Scaffold(

    backgroundColor:
    const Color(0xFFF4F5F7),

    appBar: AppBar(

    backgroundColor:
    Colors.deepPurple,

    title: const Text(
    "Método de Pago",
    style: TextStyle(
    color: Colors.white,
    ),
    ),

    ),

    body: Padding(

    padding:
    const EdgeInsets.all(20),

    child: Column(

    crossAxisAlignment:
    CrossAxisAlignment.start,

    children: [

    Card(

    elevation: 5,

    shape:
    RoundedRectangleBorder(

    borderRadius:
    BorderRadius.circular(
    20,
    ),

    ),

    child: Padding(

    padding:
    const EdgeInsets.all(
    20,
    ),

    child: Column(

    crossAxisAlignment:
    CrossAxisAlignment.start,

    children: [

    Text(

    widget.titulo,

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

    "Total a pagar",

    style:
    TextStyle(

    color:
    Colors.grey.shade700,

    ),

    ),

    const SizedBox(
    height: 5,
    ),

    Text(

    "S/ ${widget.precio}",

    style:
    const TextStyle(

    fontSize: 30,

    fontWeight:
    FontWeight.bold,

    color:
    Colors.green,

    ),

    ),

    ],

    ),

    ),

    ),

    const SizedBox(
    height: 25,
    ),

    const Text(

    "Selecciona un método",

    style: TextStyle(

    fontSize: 20,

    fontWeight:
    FontWeight.bold,

    ),

    ),

    const SizedBox(
    height: 15,
    ),

    RadioListTile(

    value: "Yape",

    groupValue:
    metodoPago,

    title:
    const Text("Yape"),

    secondary:
    const Icon(
    Icons.qr_code,
    ),

    onChanged: (value) {

    setState(() {

    metodoPago =
    value.toString();

    });

    },

    ),

    RadioListTile(

    value: "Plin",

    groupValue:
    metodoPago,

    title:
    const Text("Plin"),

    secondary:
    const Icon(
    Icons.phone_android,
    ),

    onChanged: (value) {

    setState(() {

    metodoPago =
    value.toString();

    });

    },

    ),

    RadioListTile(

    value: "Tarjeta",

    groupValue:
    metodoPago,

    title:
    const Text("Tarjeta"),

    secondary:
    const Icon(
    Icons.credit_card,
    ),

    onChanged: (value) {

    setState(() {

    metodoPago =
    value.toString();

    });

    },

    ),

    const Spacer(),

    SizedBox(

    width:
    double.infinity,

    height: 55,

    child:
    ElevatedButton.icon(

    style:
    ElevatedButton.styleFrom(

    backgroundColor:
    Colors.deepPurple,

    ),

    onPressed: () async {

    final result =
    await ApiService
        .reservarEvento(

    Session.usuarioId!,

    widget.eventoId,

    );

    if(result["success"]
    == true){

    if(context.mounted){

    showDialog(

    context: context,

    builder: (_) {

    return AlertDialog(

    title:
    const Text(
    "Pago Exitoso",
    ),

    content:
    Text(

    "Tu entrada para ${widget.titulo} fue registrada correctamente.",

    ),

    actions: [

    TextButton(

    onPressed: () {

    Navigator.pop(
    context);

    Navigator.pop(
    context);

    },

    child:
    const Text(
    "Aceptar",
    ),

    ),

    ],

    );

    },

    );

    }

    } else {

    ScaffoldMessenger
        .of(context)
        .showSnackBar(

    SnackBar(

    content: Text(

    result["message"]
    ?? "Error",

    ),

    ),

    );

    }

    },

    icon: const Icon(
    Icons.payment,
    color:
    Colors.white,
    ),

    label: const Text(

    "Pagar y Reservar",

    style: TextStyle(

    color:
    Colors.white,

    fontWeight:
    FontWeight.bold,

    ),

    ),

    ),

    ),

    ],

    ),

    ),

    );
  }

}
