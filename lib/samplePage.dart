// ignore_for_file: unused_field, unnecessary_null_comparison

import 'dart:typed_data';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
// ignore: depend_on_referenced_packages
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart' as Path;

class SamplePage extends StatefulWidget {
  @override
  _SamplePageState createState() => _SamplePageState();
}

class _SamplePageState extends State<SamplePage> {
  html.File? _cloudFile;
  Uint8List? _fileBytes;
  Image? _imageWidget;

  Future<void> _pickImage() async {
    var mediaData = await ImagePickerWeb.getImageInfo;
    String mimeType = mime(Path.basename(mediaData!.fileName!))!;
    html.File mediaFile =
        html.File(mediaData.data!, mediaData.fileName!, {'type': mimeType});

    if (mediaFile != null) {
      setState(() {
        _cloudFile = mediaFile;
        _fileBytes = mediaData.data;
        _imageWidget = Image.memory(mediaData.data!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sample Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_imageWidget != null) _imageWidget!,
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await _pickImage();
              },
              child: Text('Pick Image'),
            ),
          ],
        ),
      ),
    );
  }
}
