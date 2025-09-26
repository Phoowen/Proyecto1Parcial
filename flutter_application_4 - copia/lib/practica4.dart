import 'package:flutter/material.dart';

class Practica4 extends StatefulWidget {
  const Practica4({super.key});

  @override
  State<Practica4> createState() => _Practica4State();
}

class _Practica4State extends State<Practica4> {
  final _formKey = GlobalKey<FormState>();

  final _nombreController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true; 

  @override
  void dispose() {
    // Liberamos memoria
    _nombreController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // ====== VALIDACIONES ======
  String? _validarNombre(String? value) {
    if (value == null || value.isEmpty) {
      return 'El nombre es obligatorio';
    }
    if (value.length < 3) {
      return 'Mínimo 3 caracteres';
    }
    return null;
  }

  String? _validarEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'El email es obligatorio';
    }
    final regex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
    if (!regex.hasMatch(value)) {
      return 'Formato de email no válido';
    }
    return null;
  }

  String? _validarPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'La contraseña es obligatoria';
    }
    if (value.length < 6) {
      return 'Mínimo 6 caracteres';
    }
    return null;
  }

  // ====== ENVIAR FORMULARIO ======
  void _enviar() {
    if (_formKey.currentState!.validate()) {
      final nombre = _nombreController.text;
      final email = _emailController.text;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Registrado: $nombre ($email)"),
        ),
      );
    }
  }

  // ====== LIMPIAR FORMULARIO ======
  void _limpiar() {
    _formKey.currentState!.reset();
    _nombreController.clear();
    _emailController.clear();
    _passwordController.clear();
    setState(() {
      _obscurePassword = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registro")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.disabled, // Solo valida al enviar
          child: Column(
            children: [
              // ===== CAMPO NOMBRE =====
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: "Nombre",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: _validarNombre,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 12),

              // ===== CAMPO EMAIL =====
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                validator: _validarEmail,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 12),

              // ===== CAMPO CONTRASEÑA =====
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: "Contraseña",
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                obscureText: _obscurePassword,
                validator: _validarPassword,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 20),

              // ===== BOTONES =====
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _enviar,
                    child: const Text("Enviar"),
                  ),
                  OutlinedButton(
                    onPressed: _limpiar,
                    child: const Text("Limpiar"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
