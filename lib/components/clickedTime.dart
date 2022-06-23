import 'dart:async';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:clipboard/clipboard.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
import 'package:shared_preferences/shared_preferences.dart';

ValueNotifier<User> currentUserNotifier = ValueNotifier<User>(User.empty());
User? get user {
  return currentUserNotifier.value;
}
    whenClicked() async {
      /*var date = await FirebaseFirestore.instance.collection('users').where('last_pressed').toString();
      var date1 = DateFormat("yyyy-MM-dd:hh:mm:ss").parse(date);
      String _date = DateFormat("yyyy-MM-dd:hh:mm:ss").format(DateTime.now());
      var now = DateFormat("yyyy-MM-dd:hh:mm:ss").parse(_date);
      var now = DateTime.now();
      if(date1!.isBefore(now))
    {*/
      final clickedTime = await UserRepository.instance.getPressedTime();

      return clickedTime;
      /*}else{
      Fluttertoast.showToast(
        msg: 'You have to wait',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,

      );
      print(date1!.difference(now));
    }
*/
    }