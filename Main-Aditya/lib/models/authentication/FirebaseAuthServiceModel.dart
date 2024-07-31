// ignore_for_file: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../User.dart';
import '../user/UserHandlerModel.dart';
import 'IFirebaseAuthService.dart';

class FirebaseAuthServiceModel implements IFirebaseAuthServiceModel {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
    "email",
  ]);

  // UserModel is a custom Class which we made in user.dart
  // User is a firebase Auth class which comes inbuilt with firebase_auth package.
  UserData? _userFromFirebase(User? user,
      {String? phone, String? name, bool? isNewUser}) {
    if (user != null) {
      return UserData(
        uid: user.uid,
        email: user.email,
        displayName: user.displayName ?? name,
        photoUrl: user.photoURL,
        phone: phone,
        isNewUser: isNewUser,
      );
    }
    return null;
  }

  /// The function returns the current Firebase user.
  ///
  /// Returns:
  ///   The method is returning a User object, which can be null.
  @override
  User? getFirebaseUser() {
    return _firebaseAuth.currentUser;
  }

  /// The function `getUserDetails()` returns the user details if the current Firebase user is not null,
  /// otherwise it returns null.
  ///
  /// Returns:
  ///   The function `getUserDetails()` returns an object of type `UserData` if the current user is
  /// authenticated and not null. Otherwise, it returns null.
  UserData? getUserDetails() {
    User? firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser != null) {
      return _userFromFirebase(firebaseUser);
    }
    return null;
  }

  /// The function returns a stream of UserData objects that represent the authentication state changes in
  /// Firebase.
  ///
  /// Returns:
  ///   The method is returning a Stream of UserData objects.
  @override
  Stream<UserData?> onAuthStateChanged() {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  /// The function signs in a user with Google authentication, retrieves user data, and stores it if the
  /// user is new.
  ///
  /// Returns:
  ///   The method is returning a Future object that resolves to a UserData object.
  @override
  Future<UserData?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final authResult = await _firebaseAuth.signInWithCredential(credential);
    final user = authResult.user;

    var userData = _userFromFirebase(user);

    if (authResult.additionalUserInfo!.isNewUser) {
      await UserHandlerModel().storeUserDetails(userData);
    }

    return userData;
  }

  /// The function `signOutUser` signs out the current user using Firebase Authentication.
  ///
  /// Returns:
  ///   The `_firebaseAuth.signOut()` method is being returned.
  @override
  Future signOutUser() async {
    return _firebaseAuth.signOut();
  }

  @override
  void dispose() {}

  /// The function `signInWithEmailPassword` attempts to sign in a user with their email and password,
  /// returning their user data if successful or an error message if not.
  ///
  /// Args:
  ///   email (String): The email parameter is a string that represents the user's email address. It is
  /// used to identify the user during the sign-in process.
  ///   password (String): The `password` parameter is a string that represents the user's password for
  /// authentication.
  ///
  /// Returns:
  ///   The method `signInWithEmailPassword` returns a `Future<UserData?>`.
  @override
  Future<UserData?> signInWithEmailPassword(
      String email, String password) async {
    try {
      final authResult = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      final user = authResult.user;
      return _userFromFirebase(user);
    } on FirebaseAuthException catch (error) {
      debugPrint("Login Failed with error code : ${error.code}");
      debugPrint(error.message);
      return UserData(
        uid: null,
        email: null,
        displayName: null,
        authStatusMessage: error.message,
      );
    }
  }

  /// The function registers a user with their email, password, name, and phone number, and returns the
  /// user data if successful or an error message if registration fails.
  ///
  /// Args:
  ///   email (String): The email parameter is a string that represents the user's email address.
  ///   password (String): The password parameter is a string that represents the user's chosen password
  /// for their account.
  ///   name (String): The name parameter is a string that represents the user's name.
  ///   phone (String): The `phone` parameter is a string that represents the user's phone number. It is
  /// used to create a `UserData` object with the user's phone number as one of its properties.
  ///
  /// Returns:
  ///   The method is returning a Future<UserData?>.
  @override
  Future<UserData?> registerWithEmailPassword(
      String email, String password, String name, String phone) async {
    try {
      final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      final user = authResult.user;
      await user!.updateDisplayName(name);
      return _userFromFirebase(
        user,
        phone: phone,
        name: name,
      );
    } on FirebaseAuthException catch (error) {
      debugPrint(
          "********************************Registration Failed with error code : ${error.code}");
      debugPrint(error.message);
      return UserData(
        uid: null,
        email: null,
        displayName: null,
        authStatusMessage: error.message,
      );
    }
  }

  /// The function sends a password reset email to the provided email address using Firebase
  /// Authentication in Dart.
  ///
  /// Args:
  ///   email (String): The email parameter is the email address of the user who wants to reset their
  /// password.
  @override
  Future sendForgotPasswordEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (error) {
      debugPrint(
          "******************************** Send password reset link failed with error code : ${error.code}");
      debugPrint(error.message);
      throw Exception(error.message);
    }
  }

  /// The function updates the user's name and photo URL in Firebase and returns the updated user data.
  ///
  /// Args:
  ///   name (String): The name parameter is a string that represents the user's display name.
  ///   photoURL (String): The `photoURL` parameter is a string that represents the URL of the user's
  /// profile photo.
  ///
  /// Returns:
  ///   The method is returning a Future<UserData?>.
  @override
  Future<UserData?> updateUserData({
    String? name,
    String? photoURL,
  }) async {
    try {
      User? user = _firebaseAuth.currentUser!;
      if (name != null) {
        await user.updateDisplayName(photoURL);
      }
      if (photoURL != null) {
        await user.updatePhotoURL(photoURL);
      }
      return _userFromFirebase(user);
    } on FirebaseAuthException catch (error) {
      debugPrint("Data update failed with error code : ${error.code}");
      debugPrint(error.message);
      return UserData(
        uid: null,
        email: null,
        displayName: null,
        authStatusMessage: error.message,
      );
    }
  }
}