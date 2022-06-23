import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class User {
  final String uid;
  final String email;
  final String name;
  final String referralCode;
  final String referCode;
  final String referLink;
  final String lastPressed;
  final double balance;
  final int countReferrers;

  User({
    required this.uid,
    required this.email,
    required this.name,
    required this.referCode,
    required this.referLink,
    required this.referralCode,
    required this.balance,
    required this.countReferrers,
    required this.lastPressed,
  });

  factory User.fromJson(Map<String, dynamic> data) {
    return User(
      uid: data['uid'] ?? '',
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      referCode: data['refer_code'] ?? '',
      referLink: data['refer_link'] ?? '',
      referralCode: data['referral_code'] ?? '',
      balance: data['balance'] ??.0,
      countReferrers: data['count_referrers'] ?? 0,
      lastPressed: data['last_pressed'] ?? '',
    );
  }

  factory User.empty() {
    return User(
      uid: '',
      name: '',
      email: '',
      referCode: '',
      referLink: '',
      balance: .0,
      referralCode: '',
      countReferrers: 0,
      lastPressed: '',
    );
  }


  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.uid == uid &&
        other.email == email &&
        other.name == name &&
        other.referralCode == referralCode &&
        other.referCode == referCode &&
        other.referLink == referLink &&
        other.balance == balance &&
        other.lastPressed == lastPressed &&
        other.countReferrers == countReferrers;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        email.hashCode ^
        referralCode.hashCode ^
        name.hashCode ^
        referCode.hashCode ^
        referLink.hashCode ^
        balance.hashCode ^
        lastPressed.hashCode ^
        countReferrers.hashCode;
  }
}
