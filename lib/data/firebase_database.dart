import 'package:firebase_database/firebase_database.dart';

class MyFirebaseService {
  static MyFirebaseService? _instance;

  static MyFirebaseService get instance => _instance ??= MyFirebaseService._();

  MyFirebaseService._() : super();

  String get bookmarksPath => 'bookmarks';

  Future insertFavourite({
    required int id,
    required String type,
    required String userUuid,
    required Map<String, dynamic> jsonData,
  }) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref('$bookmarksPath/$userUuid/$type/$id');
    await ref.set(jsonData);
  }

  Future removeFavourite({required int id, required String type, required String userUuid}) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref('$bookmarksPath/$userUuid/$type/$id');
    await ref.remove();
  }
}
