import 'package:localstorage/localstorage.dart';

class Storage {
  static final Storage _storage = Storage._internal();
  static LocalStorage storage = LocalStorage('storage_app_desktop');

  factory Storage(){
    return _storage;
  }

  Future<void> save(String key, dynamic value) async {
    bool ready = await storage.ready;
    print("saving to storage 2");
    if (ready) {
      return storage.setItem(key, value);
    }
  }

  get(String key) async {

      return storage.getItem(key);
  }

  Storage._internal();


}