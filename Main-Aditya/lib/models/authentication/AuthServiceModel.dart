// ignore_for_file: file_names
import '../User.dart';
import '../../models/user/UserHandlerModel.dart';
import 'FirebaseAuthServiceModel.dart';

class AuthServiceModel {
  /// The function `loginWithGoogle` attempts to sign in a user using Google authentication and returns
  /// the user data if successful.
  ///
  /// Returns:
  ///   a Future object that resolves to a UserData object or null.
  Future<UserData?> loginWithGoogle() async {
    final authServiceProvider = FirebaseAuthServiceModel();
    UserData? userModel = await authServiceProvider.signInWithGoogle();
    return userModel;
  }

  /// The function `signOutUser` signs out the current user using the `FirebaseAuthServiceModel`.
  Future<void> signOutUser() async {
    await FirebaseAuthServiceModel().signOutUser();
  }

  /// The function `loginWithEmailPassword` takes an email and password as parameters, uses the
  /// `FirebaseAuthServiceModel` to sign in with the provided credentials, and returns a `UserData`
  /// object.
  ///
  /// Args:
  ///   email (String): The email parameter is a string that represents the user's email address.
  ///   password (String): A string representing the user's password.
  ///
  /// Returns:
  ///   a Future object that resolves to a UserData object or null.
  Future<UserData?> loginWithEmailPassword(
      String email, String password) async {
    final authServiceProvider = FirebaseAuthServiceModel();
    UserData? userModel = await authServiceProvider.signInWithEmailPassword(
      email,
      password,
    );
    return userModel;
  }

  /// The function registers a user with an email, password, name, and phone number, and stores the user
  /// details if the registration is successful.
  ///
  /// Args:
  ///   email (String): The email parameter is a string that represents the user's email address.
  ///   password (String): The password parameter is a string that represents the user's chosen password
  /// for their account.
  ///   name (String): The name parameter is a string that represents the user's name.
  ///   phone (String): The `phone` parameter is a string that represents the user's phone number.
  ///
  /// Returns:
  ///   a Future<UserData?>.
  Future<UserData?> registerWithEmailPassword(
      String email, String password, String name, String phone) async {
    final authServiceProvider = FirebaseAuthServiceModel();
    UserData? userModel = await authServiceProvider.registerWithEmailPassword(
        email, password, name, phone);
    if (userModel != null) {
      await UserHandlerModel().storeUserDetails(userModel);
    }
    return userModel;
  }

  /// The `forgotPassword` function in Dart sends a forgot password email to the specified email address
  /// using the `FirebaseAuthServiceModel`.
  ///
  /// Args:
  ///   email (String): The email address of the user who wants to reset their password.
  Future forgotPassword(String email) async {
    await FirebaseAuthServiceModel().sendForgotPasswordEmail(email);
  }
}