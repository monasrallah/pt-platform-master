import 'dart:io';

import 'package:dio/dio.dart';

class EditImageParams {
  File avatar;

  EditImageParams({required this.avatar});

  Map<String, dynamic> toJson() => {
        "avatar": avatar,
      };

  Future<FormData> toFormData() async {
    final multiPartData = FormData.fromMap(toJson());
    // if (image != null) {
    var image = await fromFileToFormData(avatar);
    multiPartData.files.add(
      MapEntry("avatar", image),
    );
    // }
    return multiPartData;
  }

  Future<MultipartFile> fromFileToFormData(File file) async {
    String fileName = file.path.split('/').last;
    var image = await MultipartFile.fromFile(file.path, filename: fileName);
    return image;
  }
}
