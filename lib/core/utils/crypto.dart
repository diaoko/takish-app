import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';

import '../../locator.dart';
import '../services/hive_service.dart';

class Crypto {

  static String encryptAES(String plaintext, String key) {
    final hiveService = locator<HiveService>();

    final cipher = AES(Key.fromUtf8(hiveService.getSecretKey()), mode: AESMode.cbc);
    final encryptedBytes = cipher.encrypt(Uint8List.fromList(plaintext.codeUnits), iv: IV.allZerosOfLength(16));

    return base64.encode(encryptedBytes.bytes);
  }

  static String decryptAES(String ciphertext) {
    final hiveService = locator<HiveService>();

    final cipher = AES(Key.fromUtf8(hiveService.getSecretKey()), mode: AESMode.cbc);
    final decryptedBytes = cipher.decrypt(Encrypted.fromBase64(ciphertext), iv: IV.allZerosOfLength(16));

    var result = utf8.decode(decryptedBytes);

    return result;
  }
}