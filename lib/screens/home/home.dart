import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laugh1/constants/constants.dart';
import 'package:laugh1/screens/home/widgets/bottom_bar.dart';
import 'package:laugh1/screens/home/widgets/choices.dart';
import 'package:laugh1/screens/home/widgets/post.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedItem = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Text("Laugh1",
            style: GoogleFonts.poppins(
                color: Constants.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 22)),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_none,
              color: Color(0xFF545D68),
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 80,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                padding: EdgeInsets.only(left: 20.0),
                children: [
                  Container(
                    height: 50,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        makeCategory(isActive: true, title: "#memes"),
                        makeCategory(isActive: false, title: "#roast"),
                        makeCategory(isActive: false, title: "#funny"),
                        makeCategory(isActive: false, title: "#vids"),
                        makeCategory(isActive: false, title: "#dark")
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  MakePost(
                      image:
                          "https://www.meme-arsenal.com/memes/28b09512dcf0befffe93f1122a59f5ef.jpg",
                      uImage:
                          "https://ichef.bbci.co.uk/news/976/cpsprodpb/D7A8/production/_108580255_hart_getty.jpg",
                      name: "Kevin Hart"),
                  MakePost(
                      image: "",
                      uImage:
                          "https://ichef.bbci.co.uk/news/976/cpsprodpb/D7A8/production/_108580255_hart_getty.jpg",
                      name: "Kevin Hart"),
                  MakePost(
                      image: "https://i.imgflip.com/61ab7k.jpg",
                      uImage: "http://192.168.1.7:8000/media/profiles/nati.jpg",
                      name: "NatiG"),
                  MakePost(
                      image:
                          "https://www.meme-arsenal.com/memes/ef7e4b1d36d712b8e45283ba3267125f.jpg",
                      uImage: "http://192.168.1.7:8000/media/profiles/nati.jpg",
                      name: "Life"),
                  MakePost(
                      image: "",
                      uImage:
                          "https://ichef.bbci.co.uk/news/976/cpsprodpb/D7A8/production/_108580255_hart_getty.jpg",
                      name: "Kevin Hart"),
                  MakePost(
                      image: "",
                      uImage:
                          "https://ichef.bbci.co.uk/news/976/cpsprodpb/D7A8/production/_108580255_hart_getty.jpg",
                      name: "Kevin Hart"),
                ],
              ),
            ),
          )
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   backgroundColor: Constants.primaryColor,
      //   child: Icon(Icons.home),
      // ),
      bottomNavigationBar: CustomBottomNavigationBar(
        iconList: [Icons.home, Icons.add_reaction, Icons.account_circle],
        onChange: (val) {
          setState(() {
            _selectedItem = val;
          });
        },
        defaultSelectedIndex: 1,
      ),
    );
  }
}
