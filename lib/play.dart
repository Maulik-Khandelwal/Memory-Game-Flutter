import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'data/data.dart';
import 'models/TileModel.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<TileModel> gridViewTiles = new List<TileModel>();
  List<TileModel> questionPairs = new List<TileModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reStart();
  }

  void reStart() {
    myPairs = getPairs();
    myPairs.shuffle();

    gridViewTiles = myPairs;
    Future.delayed(const Duration(seconds: 5), () {
// Here you can write your code
      setState(() {
        print("2 seconds done");
        // Here you can write your code for open new view
        questionPairs = getQuestionPairs();
        gridViewTiles = questionPairs;
        selected = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 90),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            points != 800
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "$points/800",
                        style: GoogleFonts.indieFlower(
                            textStyle: TextStyle(
                                color: Colors.amber,
                                fontSize: 50,
                                fontWeight: FontWeight.w900)),
                      ),
                      Text("Points",
                          style: GoogleFonts.indieFlower(
                              textStyle: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w900))),
                    ],
                  )
                : Container(),
            SizedBox(
              height: 15,
            ),
            GridView(
              shrinkWrap: true,
              //physics: ClampingScrollPhysics(),
              scrollDirection: Axis.vertical,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  mainAxisSpacing: 0.0, maxCrossAxisExtent: 100.0),
              children: List.generate(gridViewTiles.length, (index) {
                return Tile(
                  imagePathUrl: gridViewTiles[index].getImageAssetPath(),
                  tileIndex: index,
                  parent: this,
                );
              }),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                setState(() {
                  points = 0;
                  reStart();
                });
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
                  "Restart",
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
          ],
        ),
      ),
    );
  }
}

class Tile extends StatefulWidget {
  String imagePathUrl;
  int tileIndex;
  _HomeState parent;

  Tile({this.imagePathUrl, this.tileIndex, this.parent});

  @override
  _TileState createState() => _TileState();
}

class _TileState extends State<Tile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!selected) {
          setState(() {
            myPairs[widget.tileIndex].setIsSelected(true);
          });
          if (selectedTile != "") {
            /// testing if the selected tiles are same
            if (selectedTile == myPairs[widget.tileIndex].getImageAssetPath()) {
              print("add point");
              points = points + 100;
              print(selectedTile + " thishis" + widget.imagePathUrl);

              TileModel tileModel = new TileModel();
              print(widget.tileIndex);
              selected = true;
              Future.delayed(const Duration(seconds: 2), () {
                tileModel.setImageAssetPath("");
                myPairs[widget.tileIndex] = tileModel;
                print(selectedIndex);
                myPairs[selectedIndex] = tileModel;
                this.widget.parent.setState(() {});
                setState(() {
                  selected = false;
                });
                selectedTile = "";
              });
            } else {
              print(selectedTile +
                  " thishis " +
                  myPairs[widget.tileIndex].getImageAssetPath());
              print("wrong choice");
              print(widget.tileIndex);
              print(selectedIndex);
              selected = true;
              Future.delayed(const Duration(seconds: 2), () {
                this.widget.parent.setState(() {
                  myPairs[widget.tileIndex].setIsSelected(false);
                  myPairs[selectedIndex].setIsSelected(false);
                });
                setState(() {
                  selected = false;
                });
              });

              selectedTile = "";
            }
          } else {
            setState(() {
              selectedTile = myPairs[widget.tileIndex].getImageAssetPath();
              selectedIndex = widget.tileIndex;
            });

            print(selectedTile);
            print(selectedIndex);
          }
        }
      },
      child: Container(
        margin: EdgeInsets.all(5),
        child: myPairs[widget.tileIndex].getImageAssetPath() != ""
            ? Image.asset(myPairs[widget.tileIndex].getIsSelected()
                ? myPairs[widget.tileIndex].getImageAssetPath()
                : widget.imagePathUrl)
            : Container(
                color: Colors.white,
                child: Image.asset("assets/correct.png"),
              ),
      ),
    );
  }
}
