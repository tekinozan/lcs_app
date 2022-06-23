import 'package:firebase_auth/firebase_auth.dart' as u;
import 'package:flutter/cupertino.dart';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multiavatar/multiavatar.dart';
import 'package:lcs_app/avatar/my_paint.dart';
import 'package:lcs_app/avatar/svg_wrapper.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:lcs_app/models/user.dart';
import 'package:lcs_app/repositories/user_repository.dart';
import 'package:lcs_app/view/auth/auth.dart';
import 'package:lcs_app/pages/nav_pages/reward_state.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String svgCode = multiavatar('X-SLAYER');
  DrawableRoot? svgRoot;
  TextEditingController randomField = TextEditingController();
  bool isEmailVerified = false;

  _generateSvg() async {
    return SvgWrapper(svgCode).generateLogo().then((value) {
      setState(() {
        svgRoot = value!;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _generateSvg();
  }
  u.User user = u.FirebaseAuth.instance.currentUser!;
  verifyEmail() async{
    u.User user = u.FirebaseAuth.instance.currentUser!;
    await user.sendEmailVerification();
  }
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<RewardState>(context);
    return SafeArea(
        child: Scaffold(
          body: ValueListenableBuilder<User>(
            valueListenable: UserRepository.instance.currentUserNotifier,
            builder: (context, value, widget){
              if (value != User.empty()){
                return Scaffold(
                  body: Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: HexColor("#1C1C3C")
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Column(
                          children: <Widget> [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                avatarPreview(),
                                const SizedBox(width: 85.0),
                                Expanded(child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:<Widget> [
                                    Text(
                                      '\n${value.name}',
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w800),
                                      ),),
                                      Text(
                                      '${value.email}',
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.w300),
                                      ),),
                                        user!.emailVerified
                                        ?
                                    Text("Verified",style: TextStyle(color: Colors.lightGreenAccent,fontSize: 14),)
                                        :
                                    TextButton(onPressed: () async {verifyEmail();}, child: Text("Verify Email",style: TextStyle(color: Colors.lightBlue,fontSize: 14)))],

                                ),),
                                randomButton()
                              ],
                            ),
                            const SizedBox(height: 40.0),
                            Container(
                              width: 370,
                              height: 76,
                              padding: EdgeInsets.all(3.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: HexColor("#2A283F"),
                              ),
                              child: Stack(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Image.asset(
                                        "asset/referral1.png",
                                        height: 100,
                                        width: 100,
                                      ),
                                      Text(
                                        'Invite&Earn',
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                              fontSize: 16,
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
                                      const SizedBox(width:5.0),
                                      Text(
                                        'LCS',
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                              fontSize: 16,
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
                                      const SizedBox(width: 40.0),
                                      ElevatedButton(
                                          child: Text("Invite ➜"),
                                          onPressed: () async {
                                            await FlutterShare.share(
                                                title: 'LCS Refer Link',
                                                linkUrl: '${value.referLink}',
                                                chooserTitle: 'Example Chooser Title'
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.all(2),
                                              fixedSize: Size(74, 24),
                                              textStyle: TextStyle(
                                                  fontSize: 14, fontWeight: FontWeight.bold),
                                              primary: HexColor("FFEA32"),
                                              onPrimary: Colors.black87,
                                              elevation: 12,
                                              shadowColor: Colors.orange,
                                              shape: StadiumBorder())),],
                                  ),],),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "Follow us on social media",
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(color: Colors.white,fontSize: 20, fontWeight: FontWeight.w400)
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children:<Widget> [
                                IconButton(
                                    onPressed: () async {
                                      final Uri _url = Uri.parse("https://t.me/LetCoinShop");

                                      if (await launchUrl(_url)) {
                                        await launchUrl(
                                          _url,
                                        );
                                      } else {
                                        throw 'Could not launch $_url';
                                      }
                                    },
                                    icon: Icon(
                                      Icons.telegram,
                                      size: 55.0,
                                      color: HexColor("#FFFFFF"),
                                    )),
                                IconButton(
                                    onPressed: ()async {
                                      final Uri _url = Uri.parse("https://www.facebook.com/letcoinshop");

                                      if (await launchUrl(_url)) {
                                        await launchUrl(
                                          _url,
                                        );
                                      } else {
                                        throw 'Could not launch $_url';
                                      }
                                    },
                                    icon: Icon(
                                      Icons.facebook,
                                      size: 55.0,
                                      color: HexColor("#FFFFFF"),
                                    )),
                                IconButton(
                                    onPressed: () async {
                                      final Uri _url = Uri.parse("https://twitter.com/letcoinshop");

                                      if (await launchUrl(_url)) {
                                        await launchUrl(
                                          _url,
                                        );
                                      } else {
                                        throw 'Could not launch $_url';
                                      }
                                    },
                                    icon: Icon(
                                      FontAwesomeIcons.twitterSquare,
                                      size: 55.0,
                                      color: HexColor("#FFFFFF"),
                                    )),
                                IconButton(
                                    onPressed: () async {
                                      final Uri _url = Uri.parse("https://www.youtube.com/channel/UCynKKjTqlRmzKHgggutXiAA");

                                      if (await launchUrl(_url)) {
                                        await launchUrl(
                                          _url,
                                        );
                                      } else {
                                        throw 'Could not launch $_url';
                                      }
                                    },
                                    icon: Icon(
                                      FontAwesomeIcons.youtube,
                                      size: 55.0,
                                      color: HexColor("#FFFFFF"),
                                    )),
                                IconButton(
                                    onPressed: () async {
                                      final Uri _url = Uri.parse("https://www.instagram.com/accounts/login/?next=/letcoinshop/");

                                      if (await launchUrl(_url)) {
                                        await launchUrl(
                                          _url,
                                        );
                                      } else {
                                        throw 'Could not launch $_url';
                                      }
                                    },
                                    icon: Icon(
                                      FontAwesomeIcons.instagram,
                                      size: 55.0,
                                      color: HexColor("#FFFFFF"),
                                    )),
                                const SizedBox(width: 5)
                              ],
                            ),
                            const SizedBox(height: 40),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children:<Widget> [
                                  const SizedBox(width: 10),
                                  Text("About",style: GoogleFonts.poppins(
                                      textStyle: TextStyle(color: Colors.white,fontSize: 18, fontWeight: FontWeight.w600)))]),
                            const SizedBox(height: 15),
                            buildAbout(context, "White Paper", "https://docs.google.com/gview?embedded=true&url=https://letcoinshop.com/content/document/LCS%20whitepaper.pdf"),
                            Divider(height:20,thickness:0.3,color: HexColor("#E6BE29")),
                            buildAbout(context, "FAQ", "https://letcoinshop.com/"),
                            Divider(height:20,thickness:0.5,color: HexColor("#E6BE29")),
                            buildAbout(context, "Contact Us", "https://letcoinshop.com/home/formpage"),
                            Divider(height:20,thickness:1,color: HexColor("#E6BE29")),
                            const SizedBox(height: 10),
                            Text("version:1.0.0",style:TextStyle(
                              fontSize:15,
                              fontWeight:FontWeight.w400,
                              color:Colors.grey,
                            )),
                            TextButton(
                              onPressed: () {
                                state.userRepo.logOutUser();
                              },
                              child: Text('Log out', style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.red)),
                            )

                          ]
                      ),
                    ),),);
              } else {
                return const AuthWidget();

            }
          }
          ),
        ),);
  }
  GestureDetector buildAbout(BuildContext context, String title, String a){
    return GestureDetector(
      onTap: () async {
        final Uri _url = Uri.parse(a);

        if (await launchUrl(_url)) {
          await launchUrl(
            _url,
          );
        } else {
          throw 'Could not launch $_url';
        }
      },

      child:Padding(
        padding:const EdgeInsets.symmetric(vertical:8,horizontal:20),
        child:Row(
          mainAxisAlignment:MainAxisAlignment.spaceBetween,
          children:[
            Text(title,style:TextStyle(
              fontSize:18,
              fontWeight:FontWeight.w500,
              color:Colors.white,
            )),
            Icon(Icons.arrow_forward_ios,color:Colors.white)
          ],
        ),
      ), );// Padding
  }

  Widget avatarPreview() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: svgRoot == null
          ? SizedBox.shrink()
          : CustomPaint(
        painter: MyPainter(svgRoot!, Size(40.0, 40.0)),
      ),
    );
  }



  Widget randomButton() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(60),
      child: Container(
        margin: EdgeInsets.only(right: 16.0,top: 30),
        child: IconButton(
            onPressed: () {
              var l = new List.generate(12, (_) => new Random().nextInt(100));
              randomField.text = l.join();
              setState(() {
                svgCode = multiavatar(randomField.text);
              });
              _generateSvg();
            },
            icon: Icon(
              Icons.refresh_outlined,
              size: 30.0,
              color: HexColor("#FFFFFF"),
            )),
      ),
    );
  }
}



