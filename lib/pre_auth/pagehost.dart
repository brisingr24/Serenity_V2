import 'package:flutter/material.dart';
import 'package:kommunicate_flutter/kommunicate_flutter.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../mains/explore.dart';
import '../mains/forum.dart';
import '../mains/home.dart';
import '../mains/profile.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PageHost extends StatefulWidget {
  @override
  _PageHostState createState() => _PageHostState();
}

class _PageHostState extends State<PageHost> {
  int _currentIndex = 0;
  late PageController _pageController;
  bool a = false;
  final iconList = <IconData>[
    Icons.home,
    Icons.forum,
    Icons.explore,
    Icons.man,
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List<Widget> _buildScreens() {
    return [
      Home(uid: FirebaseAuth.instance.currentUser!.uid),
      Forum(uid: FirebaseAuth.instance.currentUser!.uid),
      Explore(uid: FirebaseAuth.instance.currentUser!.uid),
      Profile(uid: FirebaseAuth.instance.currentUser!.uid)
    ];
  }

  // onTap: (index) => setState(() => _currentIndex = index)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildScreens()[_currentIndex],
      floatingActionButton: FloatingActionButton(
        splashColor: Colors.orange,
        backgroundColor: Color(0xFFFFD1D1),
        onPressed: () async {
          try {
            Fluttertoast.showToast(
                msg: "Opening ChatBot,Please Wait",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0
            );
            dynamic conversationObject = {
              'appId': '29c2048ee3beeb85ee57141188a5664f0'
            };
            dynamic result = await KommunicateFlutterPlugin.buildConversation(
                conversationObject);
            print("Conversation builder success : " + result.toString());
          } on Exception catch (e) {
            print("Conversation builder error occurred : " + e.toString());
          }
        },
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 28,
          child: Image.asset("images/chatbot.png"),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: iconList,
        iconSize: 30,
        backgroundColor: Color(0xFFadeff7),
        inactiveColor: Colors.black,
        activeColor: Colors.white,
        activeIndex: _currentIndex,
        splashColor: Colors.orange,
        splashSpeedInMilliseconds: 300,
        notchSmoothness: NotchSmoothness.defaultEdge,
        gapLocation: GapLocation.center,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
