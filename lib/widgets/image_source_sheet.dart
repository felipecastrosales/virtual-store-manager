import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceSheet extends StatelessWidget {
  final Function(File) onImageSelected;
  ImageSourceSheet({this.onImageSelected});

  void imageSelected(File image) async {
    if (image != null) {
      var croppedImage = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatioPresets: [CropAspectRatioPreset.square]);
      onImageSelected(croppedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    File _image;
    final picker = ImagePicker();
    File photo;
    Future getImage(String type) async {
      final pickedFile = await picker.getImage(
        source: type == 'camera' 
          ? ImageSource.camera
          : ImageSource.gallery
      );
      return _image = File(pickedFile.path); // only return, and remove _image
    }

    return BottomSheet(
      onClosing: () {},
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FlatButton(
            child: Text('Câmera'),
            onPressed: () async {
              photo = await getImage('camera');
              imageSelected(photo);
            },
          ),
          FlatButton(
            child: Text('Galeria'),
            onPressed: () async {
              photo = await getImage('gallery');
              imageSelected(photo);
            },
          ),
        ],
      ),
    );
  }
}
