import 'dart:io';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String result = "Your Converted Text..";
  File image;
  Future<File> imageFile;
  ImagePicker imagePicker;
  //InputImage inputImage;

  pickImageFromGallery() async {
    PickedFile pickedFile =
        await imagePicker.getImage(source: ImageSource.gallery);
    image = File(pickedFile.path);
    // inputImage = InputImage.fromFilePath(image.path);

    setState(() {
      image;
      performImageLabelling();
    });
  }

  captureImageWithCamera() async {
    PickedFile pickedFile =
        await imagePicker.getImage(source: ImageSource.camera);
    image = File(pickedFile.path);
    //inputImage = InputImage.fromFilePath(image.path);

    setState(() {
      image;
      performImageLabelling();
    });
  }

  performImageLabelling() async {
    final img = InputImage.fromFile(image);
    final textDetector = GoogleMlKit.vision.textDetector();
    final RecognisedText recognisedText = await textDetector.processImage(img);

    //String text = recognisedText.text;
    result = "";
    setState(() {
      for (TextBlock block in recognisedText.blocks) {
        //final Rect rect = block.rect;
        //final List<Offset> cornerPoints = block.cornerPoints;
        //final String text = block.text;
        //final List<String> languages = block.recognizedLanguages;

        for (TextLine line in block.lines) {
          // Same getters as TextBlock
          for (TextElement element in line.elements) {
            // Same getters as TextBlock
            result += element.text + " ";
          }
        }

        result += "\n";
      }
    });
  }

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/image.jpg"),
                fit: BoxFit.cover)),
        child: Column(
          children: [
            SizedBox(
              width: 100,
            ),
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.39,
              width: MediaQuery.of(context).size.width * 0.8,
              margin: EdgeInsets.only(top: 70),
              padding: EdgeInsets.only(left: 28, bottom: 5, right: 18),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SelectableText(result,
                      style: GoogleFonts.exo(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 15))),
                ),
              ),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/note.jpg"),
                      fit: BoxFit.cover)),
            ),
            Container(
                margin: EdgeInsets.only(top: 35),
                child: Stack(
                  children: [
                    Stack(
                      children: [
                        Center(
                          child: Image.asset(
                            "assets/images/pin.png",
                            height: 280,
                            width: 280,
                          ),
                        )
                      ],
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          pickImageFromGallery();
                        },
                        onLongPress: () {
                          captureImageWithCamera();
                        },
                        child: Container(
                            margin: EdgeInsets.only(top: 25),
                            child: image != null
                                ? Image.file(image,
                                    width: 140, height: 192, fit: BoxFit.fill)
                                : Container(
                                    width: 240,
                                    height: 200,
                                    child: Icon(
                                      Icons.camera_front,
                                      size: 100,
                                      color: Colors.grey,
                                    ),
                                  )),
                      ),
                    ),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text("Click On Icon To Select An Image",
                    style: GoogleFonts.exo(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
