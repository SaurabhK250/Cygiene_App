// ignore_for_file: file_names
import '../models/User.dart';
import '../models/authentication/AuthServiceModel.dart';

class AuthController {
  /// The function `loginWithGoogle` asynchronously logs in with Google using the `AuthServiceModel`.
  Future<void> loginWithGoogle() async {
    await AuthServiceModel().loginWithGoogle();
  }

  /// The function `logOutUser` logs out the current user by calling the `signOutUser` method from the
  /// `AuthServiceModel` class.
  Future<void> logOutUser() async {
    await AuthServiceModel().signOutUser();
  }

  /// The function `loginWithEmailPassword` takes an email and password as parameters and returns a
  /// `UserData` object wrapped in a `Future`.
  ///
  /// Args:
  ///   email (String): The email parameter is a string that represents the user's email address.
  ///   password (String): The password parameter is a string that represents the user's password.
  ///
  /// Returns:
  ///   a Future object that resolves to a UserData object or null.
  Future<UserData?> loginWithEmailPassword(
      String email, String password) async {
    return await AuthServiceModel().loginWithEmailPassword(email, password);
  }

  /// The function `registerWithEmailPassword` registers a user with their email, password, name, and
  /// phone number and returns their user data.
  ///
  /// Args:
  ///   email (String): The email parameter is a string that represents the user's email address.
  ///   password (String): The password parameter is a string that represents the user's password.
  ///   name (String): The name parameter is a string that represents the user's name.
  ///   phone (String): The phone parameter is a string that represents the user's phone number.
  ///
  /// Returns:
  ///   a Future object that contains UserData or null.
  Future<UserData?> registerWithEmailPassword(
      String email, String password, String name, String phone) async {
    return await AuthServiceModel()
        .registerWithEmailPassword(email, password, name, phone);
  }

  /// The function `forgotPassword` sends a request to the `AuthServiceModel` to reset the password for a
  /// given email.
  ///
  /// Args:
  ///   email (String): The email parameter is a string that represents the user's email address.
  ///
  /// Returns:
  ///   The `forgotPassword` method is returning a `Future` object.
  Future forgotPassword(String email) async {
    return await AuthServiceModel().forgotPassword(email);
  }
}