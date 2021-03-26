import 'package:flutter_login/models/user/bucket.dart';
import 'package:flutter_login/repositories/database/init.dart';
import 'package:sembast/sembast.dart';

class SembastUserRepository {
  final StoreRef _store = intMapStoreFactory.store('user_store');

  Future<Database> get _database async => await AppDatabase.instance.database;

  Future<dynamic> addUser(User user) async {
    return _store.add(await _database, user.toJson());
  }

  Future<User?> getUser(int id) async {
    var filter = Filter.custom((snapshot) {
      var value = snapshot['id'];
      return value == id;
    });

    final finder = Finder(filter: filter);

    final snapshots = await _store.find(
      await _database,
      finder: finder,
    );
    if (snapshots.isNotEmpty)
      return User.fromJson(snapshots.first.value as Map<String, dynamic>);
    return null;
  }

  Future updateUser(User user) async {
    await _store.record(user.id).update(await _database, user.toJson());
  }

  Future deleteUser(int userId) async {
    await _store.record(userId).delete(await _database);
  }

  Future<List<User>> getAllUsers() async {
    final snapshots = await _store.find(await _database);
    return snapshots
        .map(
            (snapshot) => User.fromJson(snapshot.value as Map<String, dynamic>))
        .toList(growable: false);
  }
}
