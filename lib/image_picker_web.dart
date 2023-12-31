// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:imagepickerweb/BigVideo.dart';
import 'package:imagepickerweb/photosHistory.dart';
import 'package:imagepickerweb/samplePage.dart';


class ImagePickerWep extends StatefulWidget {
  @override 
  _ImagePickerWepState createState() => _ImagePickerWepState();
}
 
class _ImagePickerWepState extends State<ImagePickerWep> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Image_Picker')),
      body: Center(
        child: SeparatedColumn(
          mainAxisAlignment: MainAxisAlignment.center,
          separator: SizedBox(height: 8),
          children: [
            _Button(
              label: 'Sample 1',
              page: SamplePage(),
            ),
            _Button(
              label: 'Photo History',
              page: PhotosHistoryAddPage(),
            ),
            _Button(
              label: 'Big Video Upload',
              page: BigVideoUploadView(),
            ),
            // _Button(
            //   label: 'Upload Multi Videos',
            //   page: MultiVideoUploadView(),
            // ),
          ],
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    required this.label,
    required this.page,
  });

  final String label;
  final Widget page;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => page),
      ),
      child: Text(label),
    );
  }
}

class SeparatedColumn extends StatelessWidget {
  const SeparatedColumn({
    required this.separator,
    this.children = const [],
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisAlignment = MainAxisAlignment.start,
  });

  final Widget separator;
  final List<Widget> children;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;

  Iterable<Widget> _expandIndexed() sync* {
    for (var index = 0; index < children.length; index++) {
      yield children[index];
      if (index < children.length - 1) {
        yield separator;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment,
      children: _expandIndexed().toList(),
    );
  }
}