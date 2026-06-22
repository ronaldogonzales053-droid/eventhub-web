import 'package:flutter/material.dart';
import '../services/api_service.dart';

class EditarEventoScreen extends StatefulWidget {

  final Map evento;

  const EditarEventoScreen({
    super.key,
    required this.evento,
  });

  @override
  State<EditarEventoScreen> createState() =>
      _EditarEventoScreenState();
}

class _EditarEventoScreenState
    extends State<EditarEventoScreen> {

late TextEditingController tituloController;
late TextEditingController descripcionController;
late TextEditingController ubicacionController;

String fechaSeleccionada = "";
String horaSeleccionada = "";

@override
void initState() {

super.initState();

tituloController =
TextEditingController(
text: widget.evento["titulo"],
);

descripcionController =
TextEditingController(
text: widget.evento["descripcion"],
);

ubicacionController =
TextEditingController(
text: widget.evento["ubicacion"],
);

fechaSeleccionada =
widget.evento["fecha_evento"];

horaSeleccionada =
widget.evento["hora_evento"];
}  Future<void> seleccionarFecha() async {

final fecha =
await showDatePicker(

context: context,

initialDate:
DateTime.now(),

firstDate:
DateTime(2024),

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
"Editar Evento",
),
backgroundColor:
Colors.orange,
),

body: SingleChildScrollView(

padding:
const EdgeInsets.all(20),

child: Column(

children: [

const Icon(
Icons.edit_calendar,
size: 90,
color: Colors.orange,
),

const SizedBox(height: 20),            TextField(
    controller:
    tituloController,
    decoration:
    InputDecoration(
      labelText: "Título",
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

    child: ElevatedButton.icon(

      onPressed:
      seleccionarFecha,

      icon: const Icon(
        Icons.calendar_month,
      ),

      label: Text(
        fechaSeleccionada,
      ),
    ),
  ),

  const SizedBox(height: 15),

  SizedBox(
    width: double.infinity,

    child: ElevatedButton.icon(

      onPressed:
      seleccionarHora,

      icon: const Icon(
        Icons.access_time,
      ),

      label: Text(
        horaSeleccionada,
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
        Colors.orange,
      ),

      onPressed: () async {

        final result =
        await ApiService
            .editarEvento(

          int.parse(
            widget.evento["id"]
                .toString(),
          ),

          tituloController.text,

          descripcionController.text,

          fechaSeleccionada,

          horaSeleccionada,

          ubicacionController.text,

        );

        if(result["success"] == true){

          ScaffoldMessenger.of(
              context)
              .showSnackBar(

            const SnackBar(
              content: Text(
                "Evento actualizado",
              ),
            ),
          );

          Navigator.pop(
              context);

        }
      },

      child: const Text(
        "Guardar Cambios",
        style: TextStyle(
          color: Colors.white,
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