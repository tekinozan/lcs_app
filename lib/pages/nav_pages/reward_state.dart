import 'package:flutter/material.dart';
import 'package:lcs_app/repositories/user_repository.dart';

class RewardState extends ChangeNotifier {
  final userRepo = UserRepository.instance;
}
