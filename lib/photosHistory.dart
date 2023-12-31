// ignore_for_file: unused_import, unused_field

import 'dart:typed_data';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart' as Path;

class PhotosHistoryAddPage extends StatefulWidget {
  @override
  _PhotosHistoryAddPageState createState() => _PhotosHistoryAddPageState();
}

class _PhotosHistoryAddPageState extends State<PhotosHistoryAddPage> {
  List<html.File>? _cloudFiles;
  List<Uint8List>? _fileBytesList;
  List<Image>? _imageWidgets = [];

  Future<void> _pickImages() async {
    List<html.File>? mediaFiles = await ImagePickerWeb.getMultiImagesAsFile();

    if (mediaFiles != null && mediaFiles.isNotEmpty) {
      List<Uint8List> bytesList = [];

      for (var mediaFile in mediaFiles) {
        var reader = html.FileReader();
        reader.readAsArrayBuffer(mediaFile);

        await reader.onLoadEnd.first;

        List<int> bytes = Uint8List.fromList(reader.result as List<int>);
        bytesList.add(Uint8List.fromList(bytes));
        _imageWidgets!.add(Image.memory(Uint8List.fromList(bytes)));
      }

      setState(() {
        _cloudFiles = mediaFiles;
        _fileBytesList = bytesList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Photos History Add Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_imageWidgets != null)
              Expanded(
                child: ListView.builder(
                  itemCount: _imageWidgets!.length,
                  itemBuilder: (context, index) {
                    return _imageWidgets![index];
                  },
                ),
              ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await _pickImages();
              },
              child: Text('Pick Images'),
            ),
          ],
        ),
      ),
    );
  }
}

