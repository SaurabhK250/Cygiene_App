// ignore_for_file: file_names
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cygiene_ui/constants/colors.dart';
import 'package:cygiene_ui/models/authentication/FirebaseAuthServiceModel.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../models/User.dart';

class UserController {
  /// The function `uploadImageToFirebaseStorage` uploads a file to Firebase Storage and returns the
  /// download URL of the uploaded file.
  ///
  /// Args:
  ///   fileName (String): The name of the file that will be stored in Firebase Storage. It should be a
  /// unique identifier for the image file.
  ///   file (File): The `file` parameter is of type `File` and represents the image file that you want to
  /// upload to Firebase Storage.
  ///
  /// Returns:
  ///   a `Future<String>`, which represents the URL of the uploaded image in Firebase Storage.
  Future<String> uploadImageToFirebaseStorage(
      {required String fileName, required File file}) async {
    // Create a storage reference from our app
    final storageRef = FirebaseStorage.instance.ref();

    // Create a reference to 'users_profile_images/filename.jpg'
    final profileImagesRef =
        storageRef.child("users_profile_images/$fileName.jpg");

    try {
      await profileImagesRef.putFile(file);
      String uploadedFileURL = await profileImagesRef.getDownloadURL();
      return uploadedFileURL;
    } on FirebaseException catch (e) {
      throw Exception("Image upload failed ${e.message}");
    }
  }

  /// The function `updateUserProfile` updates the user's profile data, including their name and photo
  /// URL, using the `FirebaseAuthServiceModel`.
  ///
  /// Args:
  ///   name (String): The name parameter is a String that represents the updated name for the user's
  /// profile. It can be null if the name is not being updated.
  ///   photoURL (String): The `photoURL` parameter is a string that represents the URL of the user's
  /// profile photo.
  ///
  /// Returns:
  ///   a Future object that contains UserData or null.
  Future<UserData?> updateUserProfile({String? name, String? photoURL}) async {
    return await FirebaseAuthServiceModel()
        .updateUserData(name: name, photoURL: photoURL);
  }

  // Returns a String URL of the file selected from Gallery
  Future<String?> selectProfileImage({required bool captureFromCamera}) async {
    final ImagePicker picker = ImagePicker();
    // Get the source of the image
    var source = captureFromCamera ? ImageSource.camera : ImageSource.gallery;

    // Get the selected file from either of the sources
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: primaryColor,
              toolbarWidgetColor: white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );
      if (croppedFile != null) {
        return croppedFile.path;
      }
    }
    return null;
  }
}