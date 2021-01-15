import 'package:flutter/material.dart';
import 'package:placeapp/widgets/image_input.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../Provider/great_place.dart';

class AddPlaceListScreen extends StatefulWidget {
  static const routeName = "addplace";
  @override
  _AddPlaceListScreenState createState() => _AddPlaceListScreenState();
}

class _AddPlaceListScreenState extends State<AddPlaceListScreen> {
  final _titleEditingController = TextEditingController();
  File _pickedImage;
  void _selectImage(File pickedimage) {
    _pickedImage = pickedimage;
  }

  void _savedPlace() {
    if (_titleEditingController.text.isEmpty || _pickedImage == null) {
      return;
    }
    Provider.of<GreatPlace>(context,listen:false)
        .addPlace(_titleEditingController.text, _pickedImage);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Add a new Item"), backgroundColor: Colors.red[800]),
        body: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text("Enter a new place"),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: "Add an Item"),
                      controller: _titleEditingController,
                    ),
                    SizedBox(height: 10.0),
                    ImageInput(_selectImage),
                  ]),
                ),
              ),
            ),
            RaisedButton.icon(
              onPressed: _savedPlace,
              label: Text("Add Item"),
              icon: Icon(Icons.add),
              color: Colors.red[800],
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              elevation: 1.0,
            )
          ],
        ));
  }
}
