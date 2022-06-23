import 'dart:async';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:clipboard/clipboard.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lcs_app/components/clickedTime.dart';
import 'package:lcs_app/services/auth_service.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:lcs_app/models/user.dart';
import 'package:lcs_app/repositories/user_repository.dart';
import 'package:lcs_app/view/auth/auth.dart';
import 'package:lcs_app/pages/nav_pages/reward_state.dart';


class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  final List<String> imgList = [
    'https://firebasestorage.googleapis.com/v0/b/lcsdeneme.appspot.com/o/banner8.jpg?alt=media&token=119dbd56-016c-4936-bcc0-42724ace18a9',
    'https://firebasestorage.googleapis.com/v0/b/lcsdeneme.appspot.com/o/banner7.jpg?alt=media&token=66f34f98-f255-469e-91e0-b6101e1f4e15',
    'https://firebasestorage.googleapis.com/v0/b/lcsdeneme.appspot.com/o/banner5.jpg?alt=media&token=58ce15fb-36e6-4aac-9495-d7dde1ee727a',
    'https://firebasestorage.googleapis.com/v0/b/lcsdeneme.appspot.com/o/banner3.jpg?alt=media&token=b63cebda-a5db-4fac-9bed-cbfced1d7034',
    'https://firebasestorage.googleapis.com/v0/b/lcsdeneme.appspot.com/o/banner2.jpg?alt=media&token=9dac47b0-603f-4e1e-ab78-1150cf996c26',
    ];
  bool _shouldIgnore = false;
  _lockButton() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final DateTime? date = DateTime.now();
    String? _date= date!.toString();
    await prefs.setString('lastPressed',_date);
  }

  void initState(){
    super.initState();
     }


    @override
  Widget build(BuildContext context) {
    final state = Provider.of<RewardState>(context);
    return SafeArea(
      child: Scaffold(
        body: ValueListenableBuilder<User>(
            valueListenable: UserRepository.instance.currentUserNotifier,
            builder: (context, value, widget) {
              if (value != User.empty()) {
                return Scaffold(
                  body: Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: HexColor("#1C1C3C")
                    ),
                    child: SingleChildScrollView(
                        padding: const EdgeInsets.only(top: 25.0,left: 10),
                      child: Column(
                          children: <Widget> [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: 153,
                                height: 30,
                                padding: EdgeInsets.all(3.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: HexColor("#55504D"),
                                ),
                                child: Center(child: Text("Total Balance",
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: HexColor("#FFFFFF"),),),),),),
                            ]
                      ),
                            const SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                 Text("LCS",
                                  style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: HexColor("#FCCF23"),),),),
                                Container(
                                  width: 200,
                                  height: 65,
                                  alignment: Alignment.topLeft,
                                  decoration: BoxDecoration(
                                    color: HexColor("#1C1C3C"),//2A283F
                                  ),
                                  child:Text("${value.balance.toStringAsFixed(0)}",
                                        style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.w300,
                                        color: HexColor("#FFFFFF"),),),),),
                                const SizedBox(width: 15),
                                incerementButton(),

                              ],),
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Icon(
                                    FontAwesomeIcons.userGroup,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                  const SizedBox(width: 16),
                                  Text("${value.countReferrers}",
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: HexColor("#FFFFFF"),),)),
                                  const SizedBox(width: 10),
                              ],),
                            const SizedBox(height: 35.0),
                            Container(
                              width: 355,
                              height: 125,
                              padding: EdgeInsets.all(3.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    HexColor("#746541"),
                                    HexColor("#050522"),
                                  ],),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.amber.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 5,
                                    offset: Offset(0, 1), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      const SizedBox(width: 30),
                                      Column(
                                        children: <Widget> [
                                          Text(
                                        'Refer&Earn',
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white,
                                              shadows: [
                                                Shadow(
                                                  blurRadius: 12,
                                                  color: Colors.black,
                                                  offset: Offset(0, 5),
                                                ),
                                              ],
                                            )),
                                      ),
                                      Text(
                                        'LCS',
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                              fontSize: 27,
                                              fontWeight: FontWeight.w900,
                                              color: HexColor("#FCCF23"),
                                              shadows: [
                                                Shadow(
                                                  blurRadius: 12,
                                                  color: Colors.black,
                                                  offset: Offset(0, 5),
                                                ),
                                              ],
                                            )),
                                      ),
                                       ElevatedButton(
                                          child: Text("Refer ➜"),
                                          onPressed: () async {
                                            showBarModalBottomSheet(
                                                backgroundColor:HexColor("#1C1C3C"),
                                                barrierColor:Colors.transparent,
                                                context:context,
                                                builder:(_){
                                                  return Container(
                                                      height:600,
                                                      decoration:BoxDecoration(
                                                          color:HexColor("#1C1C3C"),
                                                          borderRadius:const BorderRadius.only(
                                                      topRight:Radius.circular(40),
                                                      topLeft:Radius.circular(40)
                                                  )// BorderRadius.only
                                                  ),
                                                  child: Column(
                                                    children:<Widget> [
                                                      const SizedBox(height: 12),
                                                      Text(
                                                        'Refer&Earn',
                                                        style: GoogleFonts.poppins(
                                                            textStyle: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight: FontWeight.w800,
                                                              color: Colors.white,
                                                              shadows: [
                                                                Shadow(
                                                                  blurRadius: 12,
                                                                  color: Colors.black,
                                                                  offset: Offset(0, 5),
                                                                ),
                                                              ],
                                                            )),
                                                      ),
                                                      const SizedBox(height: 35),
                                                      Image.asset(
                                                        "asset/popup.png",
                                                      ),
                                                      const SizedBox(height: 30),
                                                      Text("Share your link with your friends \n          and get 1 LCS each",
                                                        style: GoogleFonts.poppins(
                                                          textStyle: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.w500,
                                                            color: Colors.white,),),),
                                                      const SizedBox(height: 55),
                                                      Container(
                                                        width: 365,
                                                        height: 40,

                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: HexColor("#2A283F"),//2A283F
                                                          boxShadow: const [
                                                          BoxShadow(color: Colors.amber, spreadRadius: 0.7,blurRadius: 1),]
                                                        ),
                                                        child:Row(
                                                          children : <Widget>[
                                                            const SizedBox(width: 8),
                                                            Text("${value.referLink}",
                                                          style: GoogleFonts.roboto(
                                                            textStyle: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.w400,
                                                              color: HexColor("#FFFFFF"),),),),
                                                            const SizedBox(width: 95),
                                                          TextButton(
                                                            onPressed: () async{
                                                              FlutterClipboard.copy('${value.referLink}').then(( value ) => Fluttertoast.showToast(
                                                                msg: 'Link Copied',
                                                                toastLength: Toast.LENGTH_LONG,
                                                                gravity: ToastGravity.SNACKBAR,
                                                                backgroundColor: HexColor("#2A283F"),
                                                                textColor: Colors.white,
                                                                fontSize: 16.0,
                                                              ),);

                                                          }, child: Icon(
                                                            Icons.copy,
                                                            color: HexColor("#E8D100"),
                                                          ),)
                                                          ],),
                                                      ),
                                                    ],
                                                  ),);},);// BoxDecoration
                                          },
                                          style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.all(2),
                                              fixedSize: Size(74, 2),
                                              textStyle: TextStyle(
                                                  fontSize: 14, fontWeight: FontWeight.bold),
                                              primary: HexColor("#FFEA32"),
                                              onPrimary: Colors.black87,
                                              elevation: 12,
                                              shadowColor: Colors.orange,
                                              shape: StadiumBorder())),],
                                      ),
                                      const SizedBox(width: 30),
                                      Image.asset(
                                        "asset/coin.png",
                                      ),],
                                  ),],),
                            ),
                      const SizedBox(height:60),
                            Row(
                              children:<Widget>
                              [const SizedBox(width: 8),
                                Text("News",
                                style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: HexColor("#FFFFFF"),),),),],),
                      const SizedBox(height:15),
                      CarouselSlider(
                        items: imgList
                            .map((item) => Container(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                            BoxShadow(
                            color: Colors.amber,
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: Offset(0, 1), // changes position of shadow
                          ),],
                            ),
                            margin: EdgeInsets.all(5.0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                child: Stack(
                                  children: <Widget>[
                                    Image.network(item, fit: BoxFit.cover, width: 1000.0),
                                    Positioned(
                                      bottom: 0.0,
                                      left: 0.0,
                                      right: 0.0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Color.fromARGB(200, 0, 0, 0),
                                              Color.fromARGB(0, 0, 0, 0)
                                            ],
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                          ),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 20.0),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ))
                            .toList(),
                        carouselController: _controller,
                        options: CarouselOptions(
                            autoPlay: true,
                            enlargeCenterPage: true,
                            aspectRatio: 2.0,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _current = index;
                              });
                            }),
                      ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: imgList.asMap().entries.map((entry) {
                                return GestureDetector(
                                  onTap: () => _controller.animateToPage(entry.key),
                                  child: Container(
                                    width: 8.0,
                                    height: 8.0,
                                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: (Theme.of(context).brightness == Brightness.values
                                            ? Colors.white
                                            : Colors.amberAccent)
                                            .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                                  ),
                                );
                              }).toList(),),
                          ]),


                      ),


                          )
                    );

              } else {
                return const AuthWidget();
              }
            }

        ),),);
  }

  Future<User> getUser(String uid) async {
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    debugPrint("user Id ${userSnapshot.data()}");
    if (userSnapshot.exists) {
      return User.fromJson(userSnapshot.data() as Map<String, dynamic>);
    } else {
      return User.empty();
    }
  }



  Widget incerementButton(){
    return Container(
      height:50,
      width:115,
        decoration: BoxDecoration(
          color:HexColor("#FCCF23"),
          borderRadius: BorderRadius.circular(20)
        ),
        child:Center(
        child:GestureDetector(
        onTap:() async {
          whenClicked();
        },
        child:Container(
          height:50,
          width:115,
          decoration:BoxDecoration(
            color:Colors.amber,
            borderRadius:BorderRadius.circular(14),
            boxShadow:[
              BoxShadow(
              color:Colors.amber,
              spreadRadius:2,
              blurRadius:10,
              ),],),
            child:Center(
                child:Text("EARN",
                style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: HexColor("#00000"),
                  shadows: [
                    Shadow(
                      blurRadius: 15,
                      color: Colors.black,
                      offset: Offset(0, 3),
                    ),
                  ],),),),),
    ),),),);// Center
  }

}