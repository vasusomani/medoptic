import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:encrypt/encrypt.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AesEncryption {
  final key = encrypt.Key.fromUtf8(dotenv.env['AES_KEY']!);
  final iv = encrypt.IV.fromUtf8(dotenv.env['AES_IV']!);

  String encryptData(String text) {
    final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: AESMode.cbc));
    final encrypted = encrypter.encrypt(text, iv: iv);
    return encrypted.base64;
  }

  String decryptData(String text) {
    final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: AESMode.cbc));
    final decrypted = encrypter.decrypt(Encrypted.from64(text), iv: iv);
    return decrypted;
  }
}
