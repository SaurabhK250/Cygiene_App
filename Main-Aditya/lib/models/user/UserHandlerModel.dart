// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../User.dart';

class UserHandlerModel {
  final CollectionReference users =
      FirebaseFirestore.instance.collection("Users");

  /// Creates a document in database with the user data
  Future<void> storeUserDetails(UserData? user) async {
    return await users.doc(user!.email).set({
      "uid": user.uid,
      "email": user.email,
      "name": user.displayName,
      "photoUrl": user.photoUrl,
      "phone": user.phone,
      "signUpTime": FieldValue.serverTimestamp(),
    }).catchError((error) =>
        debugPrint("Failed to add user details to database: $error"));
  }

  /// The function updates a single user detail in a database using the provided key-value pair.
  ///
  /// Args:
  ///   context (BuildContext): The `BuildContext` object represents the location of the widget in the
  /// widget tree. It is typically used to access the inherited properties of a widget or to navigate to a
  /// different screen.
  ///   key (String): The key is a required parameter of type String. It represents the field name in the
  /// user document that needs to be updated.
  ///   value (dynamic): The `value` parameter is the new value that you want to update for the specified
  /// `key` in the user's details. It can be of any data type, as it is defined as `dynamic`.
  ///
  /// Returns:
  ///   a `Future<void>`.
  Future<void> updateSingleUserDetail(BuildContext context,
      {required String key, required dynamic value}) {
    var user = Provider.of<UserData?>(context, listen: false);
    return users.doc(user!.email).update({key: value}).catchError((error) =>
        debugPrint("Failed to update user details to database: $error"));
  }
}
