class Evento {
  final int id;
  final String titulo;
  final String descripcion;
  final String fechaEvento;
  final String horaEvento;
  final String ubicacion;
  final String imagen;

  Evento({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.fechaEvento,
    required this.horaEvento,
    required this.ubicacion,
    required this.imagen,
  });

  factory Evento.fromJson(
      Map<String, dynamic> json,
      ) {
    return Evento(
      id: int.parse(
        json["id"].toString(),
      ),
      titulo: json["titulo"] ?? "",
      descripcion: json["descripcion"] ?? "",
      fechaEvento: json["fecha_evento"] ?? "",
      horaEvento: json["hora_evento"] ?? "",
      ubicacion: json["ubicacion"] ?? "",
      imagen: json["imagen"] ??
          "https://picsum.photos/800/400",
    );
  }
}