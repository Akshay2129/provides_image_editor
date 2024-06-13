import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cross_file/cross_file.dart';

class ShareApp extends StatefulWidget {
  const ShareApp({super.key});

  @override
  State<ShareApp> createState() => _ShareAppState();
}

class _ShareAppState extends State<ShareApp> {
  final TextEditingController shareController = TextEditingController();
  String? filePath;

  void _shareText() {
    if (shareController.text.isNotEmpty) {
      Share.share(shareController.text);
    }
  }

  void _shareFile() async {
    if (filePath != null) {
      final XFile file = XFile(filePath!);
      Share.shareXFiles([file], text: shareController.text);
    }
  }

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        filePath = result.files.single.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Share Plus Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300, // Set the width of the TextField
              height: 100, // Set the height of the TextField
              child: TextField(
                controller: shareController,
                maxLines: null,
                decoration: InputDecoration(
                  labelText: 'Share Text',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _shareText,
              child: Text('Share Text'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _pickFile,
              child: Text('Pick File'),
            ),
            SizedBox(height: 10),
            if (filePath != null) Text('Selected File: $filePath'),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _shareFile,
              child: Text('Share File'),
            ),
          ],
        ),
      ),
    );
  }
}
