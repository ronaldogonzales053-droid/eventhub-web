import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/evento.dart';

class ApiService {

  static const String baseUrl =
      "https://eventhub-backend-production-4933.up.railway.app";

  // ==========================
  // OBTENER EVENTOS
  // ==========================

  Future<List<Evento>> obtenerEventos() async {

    final response = await http.get(
      Uri.parse("$baseUrl/obtener_eventos.php"),
    );

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);

      List<Evento> eventos = [];

      for (var item in data["data"]) {
        eventos.add(
          Evento.fromJson(item),
        );
      }

      return eventos;

    } else {

      throw Exception(
        "Error al cargar eventos",
      );
    }
  }

  // ==========================
  // LOGIN
  // ==========================

  static Future<Map<String, dynamic>> login(
      String email,
      String password,
      ) async {

    final response = await http.post(
      Uri.parse("$baseUrl/login.php"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    return jsonDecode(response.body);
  }

  // ==========================
  // REGISTRO
  // ==========================

  static Future<Map<String, dynamic>> registrar(
      String nombre,
      String email,
      String password,
      ) async {

    final response = await http.post(
      Uri.parse("$baseUrl/registrar.php"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "nombre": nombre,
        "email": email,
        "password": password,
      }),
    );

    return jsonDecode(response.body);
  }

  // ==========================
  // RESERVAR EVENTO
  // ==========================

  static Future<Map<String, dynamic>> reservarEvento(
      int usuarioId,
      int eventoId,
      ) async {

    final response = await http.post(
      Uri.parse("$baseUrl/reservar_evento.php"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "usuario_id": usuarioId,
        "evento_id": eventoId,
      }),
    );

    return jsonDecode(response.body);
  }

  // ==========================
  // MIS RESERVAS
  // ==========================

  static Future<List<dynamic>> obtenerMisReservas(
      int usuarioId,
      ) async {

    final response = await http.post(
      Uri.parse("$baseUrl/mis_reservas.php"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "usuario_id": usuarioId,
      }),
    );

    final data =
    jsonDecode(response.body);

    return data["data"];
  }

  // ==========================
  // ELIMINAR RESERVA
  // ==========================

  static Future<Map<String, dynamic>> eliminarReserva(
      int reservaId,
      ) async {

    final response = await http.post(
      Uri.parse("$baseUrl/eliminar_reserva.php"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "reserva_id": reservaId,
      }),
    );

    return jsonDecode(response.body);
  }

  // ==========================
  // CREAR EVENTO
  // ==========================

  static Future<Map<String, dynamic>> crearEvento(
      String titulo,
      String descripcion,
      String fechaEvento,
      String horaEvento,
      String ubicacion,
      ) async {

    final response = await http.post(
      Uri.parse("$baseUrl/crear_evento.php"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "titulo": titulo,
        "descripcion": descripcion,
        "fecha_evento": fechaEvento,
        "hora_evento": horaEvento,
        "ubicacion": ubicacion,
      }),
    );

    return jsonDecode(response.body);
  }
// EDITAR EVENTO
  static Future<Map<String,dynamic>>
  editarEvento(
      int id,
      String titulo,
      String descripcion,
      String fecha,
      String hora,
      String ubicacion,
      ) async {

    final response = await http.post(

      Uri.parse(
        "$baseUrl/editar_evento.php",
      ),

      headers: {
        "Content-Type":"application/json"
      },

      body: jsonEncode({

        "id":id,
        "titulo":titulo,
        "descripcion":descripcion,
        "fecha_evento":fecha,
        "hora_evento":hora,
        "ubicacion":ubicacion,

      }),

    );

    return jsonDecode(response.body);
  }
  // ELIMINAR EVENTO
  static Future<Map<String,dynamic>>
  eliminarEvento(
      int id,
      ) async {

    final response = await http.post(

      Uri.parse(
        "$baseUrl/eliminar_evento.php",
      ),

      headers: {
        "Content-Type":"application/json"
      },

      body: jsonEncode({

        "id":id,

      }),

    );

    return jsonDecode(response.body);
  }
  // OBTENER EVENTOS ADMIN
  static Future<List<dynamic>>
  obtenerEventosAdmin() async {

    final response = await http.get(
      Uri.parse(
        "$baseUrl/obtener_eventos.php",
      ),
    );

    final data =
    jsonDecode(response.body);

    return data["data"];
  }
}