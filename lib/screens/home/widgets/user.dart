import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laugh1/constants/constants.dart';

Widget makeUserFeed({image, name}) {
  return Container(
    margin: EdgeInsets.only(bottom: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.poppins(
                          color: Colors.grey[900],
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1),
                    ),
                  ],
                ),
                SizedBox(
                  height: 3,
                ),
                Row(
                  children: [
                    Text(
                      "1 hr ago",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                  ],
                )
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Avatar(
                  image: image,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

class Avatar extends StatefulWidget {
  final String image;
  const Avatar({Key? key, required this.image}) : super(key: key);

  @override
  _AvatarState createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> with SingleTickerProviderStateMixin {
  late Animation<double> animation_1;
  late Animation<double> animation_2;
  late AnimationController controller;
  double rotationAngle = 0;
  late final Animation<double> _animation;

  @override
  void initState() {
    controller =
        AnimationController(duration: Duration(seconds: 5), vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.linear,
    )..addListener(() {
        setState(() {});
      }));
    controller.repeat(reverse: true);

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 45),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topLeft,
                stops: [
                  _animation.value - 0.2,
                  _animation.value + 1,
                  _animation.value + 0.3,
                ],
                colors: [
                  Constants.primaryColor,
                  Colors.amberAccent,
                  Constants.primaryColor,
                ]),
          ),
          child: Padding(
            padding: const EdgeInsets.all(1.6),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 0.2),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: GestureDetector(
                  onTap: () {},
                  child: CircleAvatar(
                      radius: 20, backgroundImage: NetworkImage(widget.image)),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Stack(
//           children: [
//             RotationTransition(
//               turns: _animation,
//               child: Container(
//                 height: 48,
//                 width: 48,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   gradient: LinearGradient(
//                       begin: Alignment.bottomCenter,
//                       end: Alignment.topLeft,
//                       colors: [Constants.primaryColor, Colors.amberAccent]),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(1.6),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   shape: BoxShape.circle,
//                   border: Border.all(color: Colors.white, width: 0.2),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(2.0),
//                   child: GestureDetector(
//                     onTap: () {},
//                     child: CircleAvatar(
//                         radius: 20,
//                         backgroundImage: NetworkImage(widget.image)),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         )