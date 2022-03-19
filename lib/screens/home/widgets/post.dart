import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laugh1/constants/constants.dart';
import 'package:laugh1/screens/home/widgets/user.dart';
import 'package:rive/rive.dart';

class MakePost extends StatefulWidget {
  final String image;
  final String uImage;
  final String name;
  const MakePost(
      {Key? key, required this.image, required this.uImage, required this.name})
      : super(key: key);

  @override
  _MakePostState createState() => _MakePostState();
}

class _MakePostState extends State<MakePost> {
  late RiveAnimationController _controller;
  bool isReacted = false;
  // Toggles between play and pause animation states
  void _togglePlay() {
    setState(() {
      isReacted = true;
      if (isReacted) {
        _controller.isActive = !_controller.isActive;
      }
    });
  }

  /// Tracks if the animation is playing by whether controller is running
  bool get isPlaying => _controller.isActive;

  @override
  void initState() {
    super.initState();
    _controller = SimpleAnimation('idle');
  }

// onHorizontalDragEnd: (DragEndDetails details) {
//                 if (details.primaryVelocity! > 0) {
//                   // User swiped Left
//                 } else if (details.primaryVelocity! < 0) {
//                   // User swiped Right
//                   _togglePlay();
//                 }
//               },
  @override
  Widget build(BuildContext context) {
    bool condition = false;
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 2 / 1,
              child: Container(
                child: Column(
                  children: [
                    makeUserFeed(image: widget.uImage, name: widget.name),
                    widget.image == ""
                        ? GestureDetector(
                            onHorizontalDragEnd: (DragEndDetails details) {
                              if (details.primaryVelocity! > 0) {
                                // User swiped Left
                              } else if (details.primaryVelocity! < 0) {
                                // User swiped Right
                                _togglePlay();
                              }
                            },
                            onDoubleTap: () {
                              _togglePlay();
                            },
                            child: Stack(
                              children: [
                                Text(
                                  "Keldegnaw ng ke sheger atchenanki techilgn chemaki Keldegnaw ng ke sheger atchenanki techilgn chemaki",
                                  style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      color: Colors.grey[800],
                                      height: 1.5,
                                      letterSpacing: .7),
                                ),
                                isReacted
                                    ? Center(
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          child: RiveAnimation.asset(
                                            'assets/images/haha.riv',
                                            controllers: [_controller],
                                            // Update the play state when the widget's initialized
                                            onInit: (_) => setState(() {}),
                                          ),
                                        ),
                                      )
                                    : Container()
                              ],
                            ),
                          )
                        : Expanded(
                            child: Text(
                              "Keldegnaw ng ke sheger atchenanki techilgn chemaki Keldegnaw ng ke sheger atchenanki techilgn chemaki",
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Colors.grey[800],
                                  height: 1.5,
                                  letterSpacing: .7),
                            ),
                          ),
                  ],
                ),
              ),
            ),
            widget.image != ""
                ? GestureDetector(
                    onHorizontalDragEnd: (DragEndDetails details) {
                      if (details.primaryVelocity! > 0) {
                        // User swiped Left
                      } else if (details.primaryVelocity! < 0) {
                        // User swiped Right
                        _togglePlay();
                      }
                    },
                    onDoubleTap: () {
                      _togglePlay();
                    },
                    child: Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: 2 / 2,
                          child: FittedBox(
                              child: Image.network(
                            widget.image,
                            fit: BoxFit.cover,
                          )),
                        ),
                        isReacted
                            ? AspectRatio(
                                aspectRatio: 2 / 2,
                                child: Center(
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    child: RiveAnimation.asset(
                                      'assets/images/haha.riv',
                                      controllers: [_controller],
                                      // Update the play state when the widget's initialized
                                      onInit: (_) => setState(() {}),
                                    ),
                                  ),
                                ),
                              )
                            : Container()
                      ],
                    ),
                  )
                : Container(),
            SizedBox(
              height: 12,
            ),
            Container(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Container(
                      height: 10,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Container(
                        child: Center(
                      child: Draggable(
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color:
                                        Constants.primaryColor.withOpacity(.15),
                                    blurRadius: 3,
                                    offset: Offset(0, 5))
                              ]),
                          child: Center(
                            child: Icon(Icons.drag_indicator,
                                size: 15, color: Constants.primaryColor),
                          ),
                        ),
                        feedback: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white)),
                        childWhenDragging: Container(
                          height: 45,
                          child: Text(
                            "",
                            style: TextStyle(fontSize: 35),
                          ),
                        ),
                        axis: Axis.horizontal,
                        data: "trial",
                      ),
                    )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DragTarget(
                        builder: (context, acceptedData, rejectedData) {
                          return condition
                              ? Text(
                                  " 😁",
                                  style: TextStyle(fontSize: 35),
                                )
                              : Text(
                                  " 😡",
                                  style: TextStyle(fontSize: 35),
                                );
                        },
                        onWillAccept: (data) {
                          return true;
                        },
                        onAccept: (data) {
                          condition = true;
                        },
                      ),
                      DragTarget(
                        builder: (context, acceptedData, rejectedData) {
                          return condition
                              ? Text(
                                  " 😡",
                                  style: TextStyle(fontSize: 35),
                                )
                              : Text(
                                  " 😁",
                                  style: TextStyle(fontSize: 35),
                                );
                        },
                        onWillAccept: (data) {
                          return true;
                        },
                        onAccept: (data) {
                          condition = true;
                        },
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
      //  Center(
      //                   child: Container(
      //                     height: 50,
      //                     width: 50,
      //                     child: RiveAnimation.asset(
      //                       'assets/images/flying.riv',
      //                       controllers: [_controller],
      //                       // Update the play state when the widget's initialized
      //                       onInit: (_) => setState(() {}),
      //                     ),
      //                   ),
      //                 )

    //  Container(
    //           child: Stack(
    //             children: [
    //               Padding(
    //                 padding: const EdgeInsets.only(top: 12.0),
    //                 child: Container(
    //                   height: 10,
    //                   decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(25)),
    //                 ),
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.only(top: 4.0),
    //                 child: Container(
    //                     child: Center(
    //                   child: Draggable(
    //                     child: Container(
    //                       height: 30,
    //                       width: 30,
    //                       decoration: BoxDecoration(
    //                           shape: BoxShape.circle,
    //                           color: Colors.white,
    //                           boxShadow: [
    //                             BoxShadow(
    //                                 color:
    //                                     Constants.primaryColor.withOpacity(.15),
    //                                 blurRadius: 3,
    //                                 offset: Offset(0, 5))
    //                           ]),
    //                       child: Center(
    //                         child: Icon(Icons.drag_indicator,
    //                             size: 15, color: Constants.primaryColor),
    //                       ),
    //                     ),
    //                     feedback: Container(
    //                         height: 30,
    //                         width: 30,
    //                         decoration: BoxDecoration(
    //                             shape: BoxShape.circle, color: Colors.white)),
    //                     childWhenDragging: Container(
    //                       height: 45,
    //                       child: Text(
    //                         "",
    //                         style: TextStyle(fontSize: 35),
    //                       ),
    //                     ),
    //                     axis: Axis.horizontal,
    //                     data: "trial",
    //                   ),
    //                 )),
    //               ),
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   DragTarget(
    //                     builder: (context, acceptedData, rejectedData) {
    //                       return condition
    //                           ? Text(
    //                               " 😁",
    //                               style: TextStyle(fontSize: 35),
    //                             )
    //                           : Text(
    //                               " 😡",
    //                               style: TextStyle(fontSize: 35),
    //                             );
    //                     },
    //                     onWillAccept: (data) {
    //                       return true;
    //                     },
    //                     onAccept: (data) {
    //                       condition = true;
    //                     },
    //                   ),
    //                   DragTarget(
    //                     builder: (context, acceptedData, rejectedData) {
    //                       return condition
    //                           ? Text(
    //                               " 😡",
    //                               style: TextStyle(fontSize: 35),
    //                             )
    //                           : Text(
    //                               " 😁",
    //                               style: TextStyle(fontSize: 35),
    //                             );
    //                     },
    //                     onWillAccept: (data) {
    //                       return true;
    //                     },
    //                     onAccept: (data) {
    //                       condition = true;
    //                     },
    //                   ),
    //                 ],
    //               ),
    //             ],
    //           ),
    //         )
          