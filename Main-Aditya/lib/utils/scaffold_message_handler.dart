// ignore_for_file: no_leading_underscores_for_local_identifiers
import 'package:flutter/material.dart';
import '../constants/colors.dart';

/// The function `showBottomNotificationMessage` displays a floating SnackBar with a custom message and
/// optional type.
/// 
/// Args:
///   context (BuildContext): The `context` parameter is the current build context of the widget tree.
/// It is typically obtained from the `BuildContext` parameter in a widget's build method.
///   message (String): The message parameter is a required string that represents the text message to
/// be displayed in the bottom notification.
///   type (String): The "type" parameter is an optional parameter that can be used to specify the type
/// of the notification message. It can be used to differentiate between different types of messages and
/// apply different styles or behaviors accordingly.
class MessageHandler {
  static void showSnackBar(var _scaffoldKey, String message) {
    _scaffoldKey.currentState.hideCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        backgroundColor: primaryColor,
        duration: const Duration(seconds: 2),
        content: Text(
          message,
          style: const TextStyle(
            fontSize: 18,
            color: white,
          ),
        ),
      ),
    );
  }
}
