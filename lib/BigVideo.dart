// ignore_for_file: unused_field, unnecessary_null_comparison, unused_local_variable

import 'dart:typed_data';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart' as Path;

class BigVideoUploadView extends StatefulWidget {
  @override
  _BigVideoUploadViewState createState() => _BigVideoUploadViewState();
}

class _BigVideoUploadViewState extends State<BigVideoUploadView> {
  List<File>? _cloudFiles;
  List<Uint8List>? _fileBytesList;
  List<Image>? _imageWidgets;

  Future<void> _pickVideo() async {
    var mediaData = await ImagePickerWeb.getVideoInfo;
    if (mediaData != null) {
      String? mimeType = mime(Path.basename(mediaData.fileName!));
      File mediaFile = File(mediaData.fileName!);

      if (mediaFile != null) {
        setState(() {
          _cloudFiles = [mediaFile];
          _fileBytesList = [mediaData.data!];
          _imageWidgets = [Image.memory(Uint8List.fromList(mediaData.data!))];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Big Video Upload View')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_imageWidgets != null && _imageWidgets!.isNotEmpty)
              Column(
                children: _imageWidgets!,
              ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await _pickVideo();
              },
              child: Text('Choose Big Video'),
            ),
          ],
        ),
      ),
    );
  }
}
