import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final FlutterSecureStorage storage = FlutterSecureStorage();

Future <void> saveRole() async {
  await storage.write(
    key: 'role', 
    value: 'student',
  );
}

Future <void> clearRole() async {
  await storage.delete(
    key: 'role'
  );
}

Future <void> clearAllStorage() async {
  await storage.deleteAll();
}

Future <String?> getRole() async {
  return await storage.read(
    key: 'role'
  );
}