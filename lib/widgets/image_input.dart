import "package:flutter/material.dart";
import "dart:io";
import "package:path_provider/path_provider.dart" as syspaths;
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  final Function onSelectimage;
  ImageInput(this.onSelectimage);
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;
  Future<void> _takeimage() async {
    final picker = ImagePicker();
    final imageFile =
        await picker.getImage(source: ImageSource.camera, maxWidth: 700);
    if (imageFile == null) {
      return;
    }

    setState(() {
      _storedImage = File(imageFile.path);
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = File(imageFile.path).copy('${appDir.path}/$fileName');
    widget.onSelectimage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
            width: 100.0,
            height: 50.0,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black)),
            alignment: Alignment.center,
            child: _storedImage == null
                ? Text("No image has been taken", textAlign: TextAlign.center)
                : Image.file(_storedImage,
                    fit: BoxFit.cover, width: double.infinity)),
        SizedBox(width: 10.0),
        Expanded(
          child: FlatButton.icon(
            icon: Icon(Icons.camera),
            onPressed: _takeimage,
            label: Text("Take a picture"),
            color: Colors.red[900],
          ),
        )
      ],
    );
  }
}
