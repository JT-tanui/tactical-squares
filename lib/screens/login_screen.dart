import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  bool _isRegistering = false;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(title: Text(_isRegistering ? 'Register' : 'Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            if (_isRegistering) ...[
              const SizedBox(height: 16),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _countryController,
                decoration: const InputDecoration(labelText: 'Country'),
              ),
            ],
            const SizedBox(height: 24),
            ElevatedButton(
              child: Text(_isRegistering ? 'Register' : 'Login'),
              onPressed: () async {
                try {
                  if (_isRegistering) {
                    await authService.registerWithEmailAndPassword(
                      _emailController.text,
                      _passwordController.text,
                      _nameController.text,
                      _countryController.text,
                    );
                  } else {
                    await authService.signInWithEmailAndPassword(
                      _emailController.text,
                      _passwordController.text,
                    );
                  }
                  Navigator.pushReplacementNamed(context, '/play_mode_selection');
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Authentication failed')),
                  );
                }
              },
            ),
            TextButton(
              child: Text(_isRegistering ? 'Already have an account? Login' : 'Don\'t have an account? Register'),
              onPressed: () {
                setState(() {
                  _isRegistering = !_isRegistering;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

