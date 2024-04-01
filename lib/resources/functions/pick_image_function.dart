import 'dart:core';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

Future<File> pickImage(String source) async {
  final picker = ImagePicker();
  File image = File("");
  print("update clicked");
  bool granted = false;
  switch (source) {
    case 'camera':
      // if (await Permission.camera.status.isDenied) {
      //   print("test granted isDenied");

      //   if (await Permission.camera.request().isGranted) granted = true;
      // } else {
      //   print("test granted isDenied!");

      //   granted = true;
      // }
      // if (granted) {
      print("test granted $granted");
      XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        image = File(pickedFile.path);
        // save image to local gallery
        await ImageGallerySaver.saveFile(image.path);
      }
      // }
      Get.back();
      break;
    case 'gallery':
      // if (await Permission.storage.isDenied) {
      //   if (await Permission.storage.request().isGranted) granted = true;
      // } else {
      //   granted = true;
      // }
      // if (granted) {
      XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        image = File(pickedFile.path);
      }
      // }
      Get.back();
      break;
  }
  return image;
}

Future<List<XFile>> pickMultiImage(String source) async {
  final picker = ImagePicker();
  List<XFile> imagefiles = [];
  print("update clicked");
  bool granted = false;
  switch (source) {
    case 'camera':
      if (await Permission.camera.status.isDenied) {
        if (await Permission.camera.request().isGranted) granted = true;
      } else {
        granted = true;
      }
      if (granted) {
        var pickedfiles = await picker.pickMultiImage();
        //you can use ImageCourse.camera for Camera capture
        imagefiles = pickedfiles;
      }
      Get.back();
      break;
    case 'gallery':
      // if (await Permission.storage.isDenied) {
      //   if (await Permission.storage.request().isGranted) granted = true;
      // } else {
      //   granted = true;
      // }
      // if (granted) {
      var pickedfiles = await picker.pickImage(source: ImageSource.gallery);
      //you can use ImageCourse.camera for Camera capture
      if (pickedfiles != null) {
        imagefiles = [pickedfiles];
      }
      // }
      Get.back();
      break;
  }
  return imagefiles;
}
