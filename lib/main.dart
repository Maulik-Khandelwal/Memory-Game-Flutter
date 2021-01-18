import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:memory_game_flutter/play.dart';
import 'package:velocity_x/velocity_x.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Welcome(),
    );
  }
}

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 80),
            child: Center(
              child: Column(children: <Widget>[
                Container(
                  child: Text(
                    "Memory Game",
                    style: GoogleFonts.indieFlower(
                      textStyle: TextStyle(
                          color: Colors.amber,
                          fontSize: 40,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 14,
                ),
                Container(
                  height: 110,
                  child: Image.asset('assets/question.png'),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 14,
                ),
                VxSwiper(
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                  items: [
                    ImageWidget("parrot.png"),
                    ImageWidget("horse.png"),
                    ImageWidget("fox.png"),
                    ImageWidget("monkey.png"),
                    ImageWidget("panda.png"),
                    ImageWidget("rabbit.png"),
                    ImageWidget("zoo.png"),
                    ImageWidget("hippo.png"),
                  ],
                  height: 110,
                  autoPlay: true,
                  autoPlayAnimationDuration: 1.seconds,
                  autoPlayInterval: 2.seconds,
                  // autoPlay: true,
                  // autoPlayAnimationDuration: 1.seconds,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 14,
                ),
                Container(
                  height: 110,
                  child: Image.asset('assets/correct.png'),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 12,
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  },
                  child: Container(
                    height: 60,
                    width: 200,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(34),
                    ),
                    child: Text(
                      "Play",
                      style: GoogleFonts.indieFlower(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 34,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                  // SizedBox(height: 140),
                  // Container(
                  //   child: Image.asset('assets/img2.jpg'),
                  // ),
                )
              ]),
            )));
  }
}

Widget ImageWidget(String imgname) {
  return Container(
    height: 110,
    child: Image.asset('assets/$imgname'),
  );
}
