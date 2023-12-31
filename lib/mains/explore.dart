// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:project/auth/register.dart';
import 'package:project/services/google_sign.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/userModel.dart';
import '../services/user_service.dart';
import '../widgets/musicWidget.dart';


class Explore extends StatefulWidget {
  final String uid;
  const Explore({Key? key, required this.uid}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Explore> {

  _callNumber() async {
    const number = '+91913671171'; //set the number here
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }

  @override
  Widget build(BuildContext context) {
    final GoogleSignInProvider _auth = GoogleSignInProvider();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Text(
          "Explore",
          style: TextStyle(
              color: Colors.black, fontFamily: 'Pacifico', fontSize: 25,fontWeight: FontWeight.w600),
        ),
        actions: <Widget>[
          TextButton.icon(
              label: const Text(
                "Log Out",
                style: TextStyle(color: Colors.black,fontSize: 16),
              ),
              icon: const Icon(
                Icons.logout,
                color: Colors.black,
              ),
              onPressed: () async {
                _auth.logOut();
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Register()));
              })
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: Column(
          children: [
            StreamBuilder<UserModel?>(
              stream: UserService().getUserInfo(widget.uid),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data != null) {
                    UserModel user = snapshot.data!;
                    return Row(
                      children: [
                        user.profileImgURL == null
                            ? CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Image.asset(
                            "images/userdef.png",
                            height: 50,
                            width: 50,
                          ),
                        )
                            : CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                            user.profileImgURL ?? ' ',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                            '${user.name}',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Spacer(),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: ElevatedButton(
                              onPressed: _callNumber,
                              style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(6.0),
                                  backgroundColor:
                                  MaterialStateProperty.all(Colors.black),
                                  fixedSize: MaterialStateProperty.all<Size>(
                                      const Size(80, 16)),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18.0),
                                      ))),
                              child: const Text(
                                "Panic",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              )),
                        ),
                      ],
                    );
                  }
                }
                return Center();
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Games',
                      style:
                      TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    SizedBox(
                      height: 170,
                      child: Center(
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: InkWell(
                              child: Image.asset("images/game.png"),
                              onTap: () => launch(
                                  "https://play.google.com/store/search?q=alto%27s+odyssey&c=apps"),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Music',
                      style:
                      TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SingleChildScrollView(
                      padding: EdgeInsets.all(8.0),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          music_container(
                              url:
                              "https://open.spotify.com/playlist/0ffnLxCftwLzmXDO7DJEXc?si=BpKndlCtSnWcZ__V_GiSKw&utm_source=whats"),
                          music_container(
                              url:
                              "https://open.spotify.com/playlist/7msgpEqduZvJT2lqUMlM1J?si=htEEpel0SPWQER8hu3Bn4A&utm_source=whatsapp"),
                          music_container(
                              url:
                              "https://open.spotify.com/playlist/37i9dQZF1DXaq9P62qly90?si=fbd58d3915cd44a1"),
                          music_container(
                              url:
                              "https://open.spotify.com/playlist/0RofBVXfw4D6GMPTsYMK82?si=75c68e021ecf4538"),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Books',
                      style:
                      TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SingleChildScrollView(
                      padding: EdgeInsets.all(6.0),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          books_container(
                              image: "images/book1.jpg",
                              url: "https://amzn.eu/d/4KW8r0k"),
                          SizedBox(
                            width: 10,
                          ),
                          books_container(
                              image: "images/book2.jpg",
                              url: "https://amzn.eu/d/4KW8r0k"),
                          SizedBox(
                            width: 10,
                          ),
                          books_container(
                              image: "images/book3.jpg",
                              url: "https://amzn.eu/d/2BZbg2b"),
                          SizedBox(
                            width: 10,
                          ),
                          books_container(
                              image: "images/book4.jpg",
                              url: "https://amzn.eu/d/2BZbg2b"),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'More',
                      style:
                      TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SingleChildScrollView(
                      padding: EdgeInsets.all(6.0),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          more_container(
                              image: "images/vid1.jpg",
                              url: "https://youtu.be/PReWdfg2cM8"),
                          more_container(
                              image: "images/vid2.jpg",
                              url:
                              "https://www.youtube.com/watch?v=wOGqlVqyvCM"),
                          more_container(
                              image: "images/vid3.jpg",
                              url: "https://youtu.be/Bzh9HmjqwLg"),
                          more_container(
                              image: "images/vid4.jpg",
                              url: "https://youtu.be/bwP2qIC8sc4")
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
