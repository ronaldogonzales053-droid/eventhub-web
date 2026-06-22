import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/api_service.dart';

class CrearEventoScreen extends StatefulWidget {
  const CrearEventoScreen({super.key});

  @override
  State<CrearEventoScreen> createState() =>
      _CrearEventoScreenState();
}

class _CrearEventoScreenState
    extends State<CrearEventoScreen> {

  final tituloController =
  TextEditingController();

  final descripcionController =
  TextEditingController();

  final ubicacionController =
  TextEditingController();

  String fechaSeleccionada = "";
  String horaSeleccionada = "";

  Uint8List? imagenSeleccionada;

  Future<void> seleccionarImagen() async {


    final picker =
    ImagePicker();

    final XFile? imagen =
    await picker.pickImage(
    source: ImageSource.gallery,
    );

    if(imagen != null){

    final bytes =
    await imagen.readAsBytes();

    setState(() {

    imagenSeleccionada =
    bytes;

    });
    }


  }

  Future<void> seleccionarFecha() async {


    final fecha =
    await showDatePicker(

    context: context,

    initialDate:
    DateTime.now(),

    firstDate:
    DateTime.now(),

    lastDate:
    DateTime(2035),

    );

    if(fecha != null){

    setState(() {

    fechaSeleccionada =
    "${fecha.year}-${fecha.month.toString().padLeft(2,'0')}-${fecha.day.toString().padLeft(2,'0')}";

    });
    }


  }

  Future<void> seleccionarHora() async {


    final hora =
    await showTimePicker(

    context: context,

    initialTime:
    TimeOfDay.now(),

    );

    if(hora != null){

    setState(() {

    horaSeleccionada =
    "${hora.hour.toString().padLeft(2,'0')}:${hora.minute.toString().padLeft(2,'0')}:00";

    });
    }


  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(

    backgroundColor:
    const Color(0xFFF4F5F7),

    appBar: AppBar(
    title: const Text(
    "Crear Evento",
    ),
    backgroundColor:
    Colors.deepPurple,
    ),

    body: SingleChildScrollView(

    padding:
    const EdgeInsets.all(20),

    child: Column(

    children: [

    const Icon(
    Icons.event_available,
    size: 90,
    color: Colors.deepPurple,
    ),

    const SizedBox(height: 20),

    Container(

    height: 220,

    width: double.infinity,

    decoration: BoxDecoration(

    color:
    Colors.grey.shade300,

    borderRadius:
    BorderRadius.circular(
    15),

    ),

    child:
    imagenSeleccionada == null

    ? const Center(
    child: Text(
    "Sin Imagen",
    ),
    )

        : ClipRRect(

    borderRadius:
    BorderRadius.circular(
    15),

    child: Image.memory(

    imagenSeleccionada!,

    fit:
    BoxFit.cover,

    ),
    ),
    ),

    const SizedBox(height: 15),

    SizedBox(

    width: double.infinity,

    child:
    ElevatedButton.icon(

    onPressed:
    seleccionarImagen,

    icon: const Icon(
    Icons.image,
    ),

    label: const Text(
    "Seleccionar Imagen",
    ),
    ),
    ),

    const SizedBox(height: 20),

    TextField(
    controller:
    tituloController,
    decoration:
    InputDecoration(
    labelText:
    "Título",
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
    descripcionController,
    maxLines: 3,
    decoration:
    InputDecoration(
    labelText:
    "Descripción",
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
    ubicacionController,
    decoration:
    InputDecoration(
    labelText:
    "Ubicación",
    border:
    OutlineInputBorder(
    borderRadius:
    BorderRadius.circular(
    15),
    ),
    ),
    ),

    const SizedBox(height: 20),

    SizedBox(

    width: double.infinity,

    child:
    ElevatedButton.icon(

    onPressed:
    seleccionarFecha,

    icon: const Icon(
    Icons.calendar_month,
    ),

    label: Text(

    fechaSeleccionada.isEmpty

    ? "Seleccionar Fecha"

        : fechaSeleccionada,

    ),
    ),
    ),

    const SizedBox(height: 15),

    SizedBox(

    width: double.infinity,

    child:
    ElevatedButton.icon(

    onPressed:
    seleccionarHora,

    icon: const Icon(
    Icons.access_time,
    ),

    label: Text(

    horaSeleccionada.isEmpty

    ? "Seleccionar Hora"

        : horaSeleccionada,

    ),
    ),
    ),

    const SizedBox(height: 25),

    SizedBox(

    width: double.infinity,
    height: 55,

    child: ElevatedButton(

    style:
    ElevatedButton.styleFrom(
    backgroundColor:
    Colors.deepPurple,
    ),

    onPressed: () async {

    if(tituloController.text.isEmpty ||
    descripcionController.text.isEmpty ||
    ubicacionController.text.isEmpty ||
    fechaSeleccionada.isEmpty ||
    horaSeleccionada.isEmpty){

    ScaffoldMessenger.of(context)
        .showSnackBar(

    const SnackBar(
    content: Text(
    "Completa todos los campos",
    ),
    ),
    );

    return;
    }

    final result =
    await ApiService.crearEvento(

    tituloController.text,

    descripcionController.text,

    fechaSeleccionada,

    horaSeleccionada,

    ubicacionController.text,

    );

    if(result["success"] == true){

    ScaffoldMessenger.of(context)
        .showSnackBar(

    const SnackBar(
    backgroundColor:
    Colors.green,
    content: Text(
    "Evento creado correctamente",
    ),
    ),
    );

    Navigator.pop(context);

    }else{

    ScaffoldMessenger.of(context)
        .showSnackBar(

    SnackBar(
    backgroundColor:
    Colors.red,
    content: Text(
    result["message"] ??
    "Error",
    ),
    ),
    );
    }
    },

    child: const Text(
    "Guardar Evento",
    style: TextStyle(
    color: Colors.white,
    fontSize: 18,
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
