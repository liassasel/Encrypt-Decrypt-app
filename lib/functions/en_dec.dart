import 'package:encrypt/encrypt.dart' as encrypt;
import 'dart:convert';

class EncryptDecrypt {
  // Función para generar una clave AES
  static encrypt.Key generateKey() {
    return encrypt.Key.fromUtf8('my32lengthsupersecretnooneknows1'); // Clave de 32 caracteres
  }

  // Función para encriptar el mensaje
  static String encryptMessage(String message) {
    final key = generateKey(); // Genera o utiliza la clave
    final iv = encrypt.IV.fromLength(16); // Genera un IV aleatorio de 16 bytes
    final encrypter = encrypt.Encrypter(encrypt.AES(key)); // Inicializa el encriptador AES

    // Encripta el mensaje
    final encrypted = encrypter.encrypt(message, iv: iv);
    // Concatenar el IV con el mensaje encriptado y codificar en Base64
    return base64Encode(iv.bytes + encrypted.bytes);
  }

  // Función para desencriptar el mensaje
  static String decryptMessage(String encryptedMessage) {
    final key = generateKey(); // Genera o utiliza la clave
    final decodedMessage = base64Decode(encryptedMessage); // Decodifica el mensaje en Base64

    // Extraer el IV (los primeros 16 bytes) y el mensaje encriptado
    final iv = encrypt.IV(decodedMessage.sublist(0, 16)); // Los primeros 16 bytes son el IV
    final encryptedBytes = decodedMessage.sublist(16); // Los bytes restantes son el mensaje encriptado

    final encrypter = encrypt.Encrypter(encrypt.AES(key)); // Inicializa el encriptador AES

    // Desencripta el mensaje
    final decrypted = encrypter.decryptBytes(encrypt.Encrypted(encryptedBytes), iv: iv);

    return utf8.decode(decrypted); // Convertir el mensaje descifrado a String
  }
}
