class Session {

  static int? usuarioId;
  static String? nombre;
  static String? email;
  static String? rol;

  static void guardarUsuario(
      int id,
      String nombreUsuario,
      String correo,
      String rolUsuario,
      ) {
    usuarioId = id;
    nombre = nombreUsuario;
    email = correo;
    rol = rolUsuario;
  }

  static void cerrarSesion() {
    usuarioId = null;
    nombre = null;
    email = null;
    rol = null;
  }

  static bool get estaLogueado {
    return usuarioId != null;
  }

  static bool get esAdmin {
    return rol == "admin";
  }

}