import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:img_to_text/Screens/homePage.dart';
import 'package:auto_size_text/auto_size_text.dart';

class AppSplashScreen extends StatefulWidget {
  @override
  _AppSplashScreenState createState() => _AppSplashScreenState();
}

class _AppSplashScreenState extends State<AppSplashScreen>
    with SingleTickerProviderStateMixin {
  Color _newColor = Colors.white;
  Animation<double> animation;
  AnimationController controller;

  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation = Tween<double>(begin: 15, end: 180).animate(controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/image.jpg"),
                  fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeText(
                  "Image 2 Text Convertor",
                  style: GoogleFonts.exo(
                      textStyle: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30)),
                  maxLines: 1,
                ),
                Padding(padding: const EdgeInsets.all(18.0)),
                Center(
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    height: animation.value,
                    width: animation.value,
                    child: TweenAnimationBuilder(
                      tween: ColorTween(begin: Colors.red, end: _newColor),
                      duration: Duration(seconds: 2),
                      curve: Curves.fastLinearToSlowEaseIn,
                      onEnd: () {
                        setState(() {
                          _newColor = _newColor == Colors.white
                              ? Colors.red
                              : Colors.white;
                        });
                      },
                      builder: (_, Color color, __) {
                        return ColorFiltered(
                          child: Image.network(
                            "https://techviral.net/wp-content/uploads/2018/06/OCR-TOOL.jpg",
                            fit: BoxFit.fill,
                          ),
                          colorFilter:
                              ColorFilter.mode(color, BlendMode.modulate),
                        );
                      },
                    ),
                  ),
                ),
                Padding(padding: const EdgeInsets.all(30.0)),
                Container(
                  height: 50,
                  width: 175,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return HomePage();
                          },
                        ));
                      },
                      style: ElevatedButton.styleFrom(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                      ),
                      child: AutoSizeText(
                        'Convert Now!!',
                        style: GoogleFonts.exo(
                            textStyle:
                                TextStyle(color: Colors.white, fontSize: 18)),
                        maxLines: 1,
                      )),
                )
              ],
            ),
          )),
    );
  }
}
