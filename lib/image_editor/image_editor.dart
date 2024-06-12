import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:image_editor_plus/options.dart';

class ImageEditorExample extends StatefulWidget {
  const ImageEditorExample({super.key});

  @override
  createState() => _ImageEditorExampleState();
}

class _ImageEditorExampleState extends State<ImageEditorExample> {
  Uint8List? imageData;

  Future<void> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        imageData = bytes;
      });
    }
  }

  Future<void> editImage() async {
    var editedImage = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageEditor(
          image: imageData,
          cropOption: CropOption(),
          flipOption: FlipOption(),
          rotateOption: RotateOption(),
          blurOption: BlurOption(),
          brushOption: BrushOption(),
          emojiOption: EmojiOption(),
          filtersOption: FiltersOption(),
          imagePickerOption: ImagePickerOption(),
          textOption: TextOption(),
        ),
      ),
    );

    if (editedImage != null) {
      setState(() => imageData = editedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ImageEditor Example"),
        centerTitle: true,
      ),
      body: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (imageData != null)
                    Image.memory(imageData!, height: 400, fit: BoxFit.contain),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      await pickImage(ImageSource.gallery);
                    },
                    child: const Text("Select from Gallery"),
                  ),SizedBox(height: 20,),
                  ElevatedButton(
                    onPressed: () async {
                      await pickImage(ImageSource.camera);
                    },
                    child: const Text("Take a Photo"),
                  ),
                  if (imageData != null) ...[
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: editImage,
                      child: const Text("Edit Image"),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
