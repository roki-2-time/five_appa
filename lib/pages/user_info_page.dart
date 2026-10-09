import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'registration_page.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  String _name = '';
  String _email = '';
  String _phone = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Загрузка данных из SharedPreferences
  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('user_name') ?? 'Не указано';
      _email = prefs.getString('user_email') ?? 'Не указано';
      _phone = prefs.getString('user_phone') ?? 'Не указано';
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль пользователя'),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.person, color: Colors.blue),
                  title: const Text('Имя'),
                  subtitle: Text(_name),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.email, color: Colors.blue),
                  title: const Text('Email'),
                  subtitle: Text(_email),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.phone, color: Colors.blue),
                  title: const Text('Телефон'),
                  subtitle: Text(_phone),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegistrationPage(),
                      ),
                    );
                  },
                  child: const Text('Назад к регистрации'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}