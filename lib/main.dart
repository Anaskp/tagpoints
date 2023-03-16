// import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Flutter Card Stack'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   late List<Widget> cardList;

//   void _removeCard(drag, index) {
//     if (drag.offset.direction > 1) {
//       setState(() {
//         cardList.removeAt(index);
//       });
//       print("Swipe left");
//     } else {
//       setState(() {
//         cardList.removeAt(index);
//       });
//       print("Swipe right");
//     }
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     cardList = _getMatchCard();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Stack(
//           alignment: Alignment.center,
//           children: cardList,
//         ),
//       ),
//     );
//   }

//   List<Widget> _getMatchCard() {
//     List<MatchCard> cards = [];
//     cards.add(MatchCard(255, 0, 0, 20));
//     cards.add(MatchCard(0, 255, 0, 40));
//     cards.add(MatchCard(0, 0, 255, 60));

//     List<Widget> cardList = [];

//     for (int x = 0; x < 3; x++) {
//       cardList.add(Positioned(
//         //top: cards[x].margin,
//         right: cards[x].margin,
//         child: Draggable(
//           onDragEnd: (drag) {
//             _removeCard(drag, x);
//           },
//           childWhenDragging: Container(),
//           feedback: Card(
//             elevation: 12,
//             color: Color.fromARGB(255, cards[x].redColor, cards[x].greenColor,
//                 cards[x].blueColor),
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//             child: Container(
//               width: 240,
//               height: 300,
//             ),
//           ),
//           child: Card(
//             elevation: 12,
//             color: Color.fromARGB(255, cards[x].redColor, cards[x].greenColor,
//                 cards[x].blueColor),
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//             child: Container(
//               width: 240,
//               height: 300,
//             ),
//           ),
//         ),
//       ));
//     }

//     return cardList;
//   }
// }

// class MatchCard {
//   int redColor = 0;
//   int greenColor = 0;
//   int blueColor = 0;
//   double margin = 0;

//   MatchCard(int red, int green, int blue, double marginTop) {
//     redColor = red;
//     greenColor = green;
//     blueColor = blue;
//     margin = marginTop;
//   }
// }

import 'package:flutter/material.dart';
import 'package:show_more_text_popup/show_more_text_popup.dart';

void main() => runApp(MyApp());

final images = [
  'images/prod1.png',
  'images/prod2.jpeg',
  'images/prod3.jpeg',
];

final newPoints = {};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            GridView.builder(
              shrinkWrap: true,
              itemCount: images.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ViewImage(
                              img: images[index],
                            ),
                          ),
                        ),
                    child: Image.asset(images[index]));
              },
            ),
            const SizedBox(
              height: 20,
            ),
            newPoints.isEmpty
                ? const SizedBox.shrink()
                : GridView.builder(
                    shrinkWrap: true,
                    itemCount: newPoints.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => NewDetailView(
                                  points: newPoints[
                                      newPoints.keys.elementAt(index)],
                                  img: newPoints.keys.elementAt(index),
                                ),
                              ),
                            );
                          },
                          child: Image.asset(newPoints.keys.elementAt(index)));
                    },
                  ),
          ],
        ),
      ),
    );
  }
}

class ViewImage extends StatelessWidget {
  const ViewImage({super.key, required this.img});

  final String img;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Points'),
        ),
        body: SizedBox(
          width: 300,
          height: 500,
          child: LayoutBuilder(
            builder: (c, p0) {
              return GestureDetector(
                onTapDown: (details) {
                  List _tempList = [
                    'hello',
                    p0.maxWidth / details.localPosition.dx,
                    p0.maxHeight / details.localPosition.dy,
                  ];

                  if (newPoints.containsKey(img)) {
                    List _currList = newPoints[img];
                    _currList.add(_tempList);
                    newPoints.update(img, (value) => _currList);
                  } else {
                    newPoints[img] = [_tempList];
                  }
                },
                child: Image.asset(
                  img,
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class NewDetailView extends StatelessWidget {
  const NewDetailView({super.key, required this.points, required this.img});

  final List points;
  final String img;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('view Points')),
        body: Container(
          width: 350,
          height: 600,
          decoration: BoxDecoration(
              image:
                  DecorationImage(fit: BoxFit.cover, image: AssetImage(img))),
          child: Stack(
            children: [
              for (var i = 0; i < points.length; i++) ...[
                Positioned(
                  left: 350 / points[i][1],
                  top: 600 / points[i][2],
                  child: GestureDetector(
                    onTap: () {
                      ShowMoreTextPopup popup = ShowMoreTextPopup(context,
                          text: points[i][0], height: 50, width: 100);

                      popup.show(
                          rect: Rect.fromLTWH(
                              350 / points[i][1], 600 / points[i][2], 0, 0));
                    },
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
