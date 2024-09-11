import 'package:encrypt_decrypt/functions/en_dec.dart';
import 'package:flutter/material.dart';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/services.dart';


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _encryptt = true; // Para controlar si se está encriptando o desencriptando
  String _message = ''; // Mensaje que se encriptará o desencriptará
  String _resultMessage = ''; // Resultado de la encriptación o desencriptación

  // Copy to clipboard 
  void _copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Copied'))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/home screen.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Texto de título según si está en modo encriptar o desencriptar
              if (_encryptt) ...[
                Text(
                  'Encrypt your\ntext here'.toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 40,
                  ),
                  textAlign: TextAlign.center,
                ),
              ] else ...[
                Text(
                  'Decrypt your\ntext here'.toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 40,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _encryptt = true;
                      });
                    },
                    child: const Text(
                      'Encrypt',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _encryptt = false;
                      });
                    },
                    child: const Text(
                      'Decrypt',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              // Mostrar el formulario correspondiente
              if (_encryptt) ...[
                _encryptForm(),
              ] else ...[
                _decryptForm(),
              ],
              const SizedBox(height: 20),
              // Mostrar el resultado de la encriptación o desencriptación
              Container(
                width: 200,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Text('$_resultMessage',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                                            ),
                      ),
                    IconButton(
                      onPressed: _resultMessage.isNotEmpty
                      ? () => _copyToClipboard(_resultMessage)
                      : null, 
                      icon: const Icon(Icons.copy),
                      color: Colors.white,
                      ),
                      
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Formulario de encriptación
  Widget _encryptForm() {
    return Column(
      children: [
        Container(
          width: 400,
          child: TextField(
            onChanged: (value) => _message = value,
            decoration:  InputDecoration(
              fillColor: Colors.white,
              filled: true,
              labelText: 'Enter message to encrypt',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15)
              ),
            ),
            maxLines: 1,
          ),
        ),
        const SizedBox(height: 10),
        InkWell(
          onTap: () {
            setState(() {
              // Llamar a la función de encriptación
              _resultMessage = EncryptDecrypt.encryptMessage(_message);
            });
          },
          child: Container(
            width: 150,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xff516d95),
              borderRadius: BorderRadius.circular(15)
            ),
            child: const Center(
              child: Text(
                'Encrypt',
                style: TextStyle(
                  fontSize: 18,
                  color:  Color(0xff001522),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          
        ),
      ],
    );
  }

  // Formulario de desencriptación
  Widget _decryptForm() {
    return Column(
      children: [
        Container(
          width: 400,
          child: TextField(
            onChanged: (value) => _message = value,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              labelText: 'Enter message to decrypt',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15)
              ),
            ),
          ),
        ),
        const SizedBox(height: 10,),
        InkWell(
          onTap: () {
            setState(() {
              // Llamar a la función de desencriptar
              _resultMessage = EncryptDecrypt.decryptMessage(_message);
            });
          },
          child: Container(
            width: 150,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xff516d95),
              borderRadius: BorderRadius.circular(15)
            ),
            child: const Center(
              child: Text(
                'Encrypt',
                style: TextStyle(
                  fontSize: 18,
                  color:  Color(0xff001522),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          
        ),
      ],
    );
  }
}