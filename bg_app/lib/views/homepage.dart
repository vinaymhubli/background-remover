import 'dart:io';

import 'package:before_after/before_after.dart';
import 'package:bg_app/utlis/border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

import '../auth/api.dart';

class EditorHome extends StatefulWidget {
  const EditorHome({super.key});

  @override
  State<EditorHome> createState() => _EditorHomeState();
}

class _EditorHomeState extends State<EditorHome> {
  var loaded = false;
  Uint8List? image;
  var removedbg = false;
  String imagePath = "";
  var isloading = false;
  ScreenshotController screenshotcontroller = ScreenshotController();
  pickimage() async {
    final img = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (img != null) {
      imagePath = img.path;

      loaded = true;
      setState(() {});
    } else {}
  }

  downloadImage() async {
    var per = await Permission.storage.request();
    var folderName = "BGRemover";
    var fileName = "${DateTime.now().microsecondsSinceEpoch}.png";
    if (per.isGranted) {
      final directory = Directory("storage/emulated/0/' + 'MemeGenerator");
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      await screenshotcontroller.captureAndSave(directory.path,
          delay: Duration(milliseconds: 100),
          fileName: fileName,
          pixelRatio: 1.0);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Downloaded Sucessfully"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                downloadImage();
              },
              icon: Icon(Icons.download))
        ],
        elevation: 0.0,
        title: Text(
          "Background Remover",
          style: GoogleFonts.aldrich(
              fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: removedbg
            ? BeforeAfter(
                beforeImage: Image.file(File(imagePath)),
                afterImage: Screenshot(
                    controller: screenshotcontroller,
                    child: Image.memory(image!)))
            : loaded
                ? GestureDetector(
                    onTap: () {
                      pickimage();
                    },
                    child: Image.file(File(imagePath)))
                : DashedBorder(
                    padding: EdgeInsets.all(40.0),
                    color: Colors.teal,
                    radius: 22,
                    child: SizedBox(
                      width: 200,
                      child: ElevatedButton(
                          onPressed: () {
                            pickimage();
                          },
                          child: Text("Remove Background")),
                    )),
      ),
      bottomNavigationBar: SizedBox(
          height: 46.0,
          child: ElevatedButton(
              onPressed: loaded
                  ? () async {
                      setState(() {
                        isloading = true;
                      });
                      image = await Api.removeBg(imagePath);
                      if (image != null) {
                        removedbg = true;
                        isloading = false;
                        setState(() {});
                      }
                    }
                  : null,
              child: isloading
                  ? CircularProgressIndicator(
                      color: Colors.white,
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    )
                  : Text(
                      "Remove Backgrund",
                      style: TextStyle(fontSize: 15.0),
                    ))),
    );
  }
}
