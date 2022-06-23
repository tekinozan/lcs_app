import 'package:firebase_auth/firebase_auth.dart' as u;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lcs_app/pages/nav_pages/reward_state.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/user.dart';
import '../../repositories/user_repository.dart';
import '../../view/auth/auth.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {

  @override
  void initState() {
    super.initState();
  }
  u.User user = u.FirebaseAuth.instance.currentUser!;
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
                            const SizedBox(height: 40),
                            Row(
                                children:<Widget>
                                [
                                  const SizedBox(width: 16),
                                Text("Your Balance",
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: HexColor("#FFFFFF"),),),),],),
                            const SizedBox(height: 12 ),
                            Container(
                              width: 370,
                              height: 150,
                              padding: EdgeInsets.all(3.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: HexColor("#2A283F"),
                                boxShadow:[
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5), //color of shadow
                                    spreadRadius: 2, //spread radius
                                    blurRadius: 5, // blur radius
                                    offset: Offset(0, 10), // changes position of shadow

                                  ),
                                ],
                              ),
                              child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      const SizedBox(width: 10),
                                      CircularPercentIndicator(
                                        radius: 50.0,
                                        lineWidth: 13.0,
                                        animation: true,
                                        percent: (value.balance) / 100000,
                                        circularStrokeCap: CircularStrokeCap.round,
                                        backgroundColor: Colors.white,
                                        progressColor: Colors.amber,
                                      ),
                                      const SizedBox(width: 30),

                                     Column(
                                       mainAxisAlignment: MainAxisAlignment.center,
                                       children:<Widget> [
                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.center,
                                           children: [
                                           Text("LCS",
                                             style: GoogleFonts.poppins(
                                               textStyle: TextStyle(
                                                 fontSize: 20,
                                                 fontWeight: FontWeight.w800,
                                                 color: HexColor("#FCCF23"),),),),
                                           Container(
                                             width: 150,
                                             height: 70,
                                             decoration: BoxDecoration(
                                               color: HexColor("#2A283F"),//2A283F
                                             ),
                                             child:Text("${value.balance.toStringAsFixed(0)}",
                                               style: GoogleFonts.poppins(
                                                 textStyle: TextStyle(
                                                   fontSize: 40,
                                                   fontWeight: FontWeight.w300,
                                                   color: HexColor("#FFFFFF"),),),),),
                                         ],),
                                         Row(children:<Widget>
                                         [
                                           const SizedBox(width: 100),
                                           Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(2),
                                            color: HexColor("#FFFFFF"),//2A283F
                                          ),),const SizedBox(width: 5),
                                         Text("Withdraw Limit",style: TextStyle(color: Colors.white,fontSize: 12),),],),
                                         Row(children:<Widget> [
                                           const SizedBox(width: 90),
                                           Container(
                                           width: 10,
                                           height: 10,
                                           decoration: BoxDecoration(
                                             borderRadius: BorderRadius.circular(2),
                                             color: HexColor("#FCCF23"),//2A283F
                                           ),),const SizedBox(width: 5),
                                           Text("Your Balance",style: TextStyle(color: Colors.white,fontSize: 12) ,)],),
                                       ],),

                                    ],),),
                                  const SizedBox(height: 40),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children:<Widget> [
                                      GestureDetector(
                                        onTap: () async {
                                          if(value.balance < 5000 && user.emailVerified ==false) {
                                            Fluttertoast.showToast(
                                              msg: 'Minimum balance must be 5000LCS\nand verify your email',
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.SNACKBAR,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0,
                                            );
                                          }
                                          else if(value.balance < 5000 && user.emailVerified){
                                            Fluttertoast.showToast(
                                              msg: 'Minimum balance must be 5000LCS',
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.SNACKBAR,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0,
                                            );
                                          }
                                          else if(value.balance > 5000 && user.emailVerified==false){
                                            Fluttertoast.showToast(
                                              msg: 'You have to verify your email',
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.SNACKBAR,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0,
                                            );
                                          }
                                          else{
                                            final Uri _url = Uri.parse("https://letcoinshop.com/home/formpage");

                                            if (await launchUrl(_url)) {
                                              await launchUrl(
                                                _url,
                                              );
                                            } else {
                                              throw 'Could not launch $_url';
                                            }
                                            Fluttertoast.showToast(
                                              msg: 'Please fill the form',
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.SNACKBAR,
                                              backgroundColor: HexColor("#2A283F"),
                                              textColor: Colors.lightGreenAccent,
                                              fontSize: 16.0,
                                            );
                                          }
                                        },
                                        child:Container(
                                          width: 120,
                                          height: 40,
                                          padding: EdgeInsets.all(3.0),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: HexColor("#2A283F"),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children:[ Image.asset(
                                              "asset/deposite.png",
                                              color: Colors.amber,
                                              width: 20,
                                              height: 20,
                                            ),
                                              const SizedBox(width: 3),
                                              Text("Deposite",
                                                style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: HexColor("#FCCF23"),),),),
                                              
                                            ],),
                                          ),
                                        ),
                                      GestureDetector(
                                        onTap: (){
                                          Fluttertoast.showToast(
                                            msg: 'Coming Soon!',
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.SNACKBAR,
                                            backgroundColor: HexColor("2A283F"),
                                            textColor: Colors.lightBlueAccent,
                                            fontSize: 16.0,

                                          );
                                        },
                                        child:Container(
                                          width: 120,
                                          height: 40,
                                          padding: EdgeInsets.all(3.0),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: HexColor("#2A283F"),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children:[ Image.asset(
                                              "asset/transfer.png",
                                              color: Colors.amber,
                                              width: 20,
                                              height: 20,
                                            ),
                                              const SizedBox(width: 3),
                                              Text("Transfer",
                                                style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: HexColor("#FCCF23"),),),),

                                            ],),
                                        ),),
                                    ],
                                  ),
                            const SizedBox(height: 20),
                            Image.asset(
                              "asset/diamond.png",
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

}
