import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../services/session.dart';
import 'register_screen.dart';
import 'eventos_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(

      body: Container(

        decoration: const BoxDecoration(

          image: DecorationImage(

            image: AssetImage(
              "assets/images/login_bg.jpg",
            ),

            fit: BoxFit.cover,

          ),

        ),

        child: Container(

          color: Colors.black.withOpacity(0.65),

          child: Center(

            child: SingleChildScrollView(

              child: Container(

                width: 500,

                padding: const EdgeInsets.all(35),

                margin: const EdgeInsets.all(20),

                decoration: BoxDecoration(

                  color: Colors.white.withOpacity(0.95),

                  borderRadius:
                  BorderRadius.circular(30),

                  boxShadow: const [

                    BoxShadow(

                      color: Colors.black26,

                      blurRadius: 25,

                      offset: Offset(0, 10),

                    ),

                  ],

                ),

                child: Column(

                  mainAxisSize: MainAxisSize.min,

                  children: [

                    Container(

                      padding: const EdgeInsets.all(20),

                      decoration: BoxDecoration(

                        color:
                        Colors.deepPurple.shade100,

                        shape: BoxShape.circle,

                      ),

                      child: const Icon(

                        Icons.event_available,

                        size: 70,

                        color: Colors.deepPurple,

                      ),

                    ),

                    const SizedBox(height: 20),

                    const Text(

                      "EVENTHUB",

                      style: TextStyle(

                        fontSize: 42,

                        fontWeight: FontWeight.bold,

                        letterSpacing: 2,

                      ),

                    ),

                    const SizedBox(height: 10),

                    const Text(

                      "Descubre • Reserva • Vive",

                      style: TextStyle(

                        fontSize: 18,

                        color: Colors.deepPurple,

                        fontWeight: FontWeight.w500,

                      ),

                    ),

                    const SizedBox(height: 30),

                    TextField(

                      controller: emailController,

                      decoration: InputDecoration(

                        hintText:
                        "Correo electrónico",

                        prefixIcon: const Icon(

                          Icons.email_outlined,

                          color: Colors.deepPurple,

                        ),

                        filled: true,

                        fillColor:
                        Colors.grey.shade100,

                        border:
                        OutlineInputBorder(

                          borderRadius:
                          BorderRadius.circular(
                            18,
                          ),

                          borderSide:
                          BorderSide.none,

                        ),

                      ),

                    ),

                    const SizedBox(height: 15),

                    TextField(

                      controller:
                      passwordController,

                      obscureText: true,

                      decoration:
                      InputDecoration(

                        hintText:
                        "Contraseña",

                        prefixIcon:
                        const Icon(

                          Icons.lock_outline,

                          color:
                          Colors.deepPurple,

                        ),

                        filled: true,

                        fillColor:
                        Colors.grey.shade100,

                        border:
                        OutlineInputBorder(

                          borderRadius:
                          BorderRadius.circular(
                            18,
                          ),

                          borderSide:
                          BorderSide.none,

                        ),

                      ),

                    ),

                    const SizedBox(height: 25),

                    SizedBox(

                      width: double.infinity,

                      height: 60,

                      child: ElevatedButton(

                        onPressed: () async {

                          final result =
                          await ApiService.login(

                            emailController.text,

                            passwordController.text,

                          );

                          if(result["success"] == true){

                            final usuario =
                            result["usuario"];

                            Session.guardarUsuario(

                              int.parse(
                                usuario["id"]
                                    .toString(),
                              ),

                              usuario["nombre"]
                                  ?? "",

                              usuario["email"]
                                  ?? "",

                              usuario["rol"]
                                  ?? "cliente",

                            );

                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(

                              const SnackBar(

                                content: Text(
                                  "Bienvenido a EventHub",
                                ),

                              ),

                            );

                            Navigator.pushReplacement(

                              context,

                              MaterialPageRoute(

                                builder: (_) =>
                                const EventosScreen(),

                              ),

                            );

                          } else {

                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(

                              SnackBar(

                                content: Text(

                                  result["message"]
                                      ?? "Error de login",

                                ),

                              ),

                            );

                          }

                        },

                        style:
                        ElevatedButton.styleFrom(

                          backgroundColor:
                          const Color(0xFF6A1B9A),

                          elevation: 10,

                          shape:
                          RoundedRectangleBorder(

                            borderRadius:
                            BorderRadius.circular(
                              20,
                            ),

                          ),

                        ),

                        child: const Text(

                          "Iniciar Sesión",

                          style: TextStyle(

                            fontSize: 20,

                            color: Colors.white,

                            fontWeight:
                            FontWeight.bold,

                          ),

                        ),

                      ),

                    ),

                    const SizedBox(height: 20),

                    TextButton(

                      onPressed: () {

                        Navigator.push(

                          context,

                          MaterialPageRoute(

                            builder: (_) =>
                            const RegisterScreen(),

                          ),

                        );

                      },

                      child: const Text(

                        "¿No tienes cuenta? Regístrate",

                        style: TextStyle(
                          fontSize: 16,
                        ),

                      ),

                    ),

                  ],

                ),

              ),

            ),

          ),

        ),

      ),

    );

  }
}