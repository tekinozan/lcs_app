import 'package:flutter/material.dart';
import 'package:lcs_app/pages/nav_pages/home_page.dart';
import 'package:lcs_app/pages/nav_pages/profile_page.dart';
import 'package:lcs_app/pages/nav_pages/wallet_page.dart';
import 'package:provider/provider.dart';
import 'package:lcs_app/models/user.dart';
import 'package:lcs_app/repositories/user_repository.dart';
import 'package:lcs_app/view/auth/auth.dart';
import 'package:lcs_app/pages/nav_pages/reward_state.dart';
import 'package:hexcolor/hexcolor.dart';

class RewardView extends StatefulWidget {
  const RewardView({Key? key}) : super(key: key);

  @override
  State<RewardView> createState() => _RewardViewState();
}

class _RewardViewState extends State<RewardView> {
  List pages = [
    WalletPage(),
    HomePage(),
    ProfilePage(),
  ];
  int currentIndex = 1;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
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
                  body: pages[currentIndex],
                bottomNavigationBar: BottomNavigationBar(
                  backgroundColor: HexColor("1C1C3C"),
                  onTap: onTap,
                  type: BottomNavigationBarType.fixed,
                  currentIndex: currentIndex,
                  selectedItemColor: HexColor("FFDE69"),
                  unselectedItemColor: Colors.white,
                  showUnselectedLabels: false,
                  showSelectedLabels: false,
                  elevation: 35,
                  items: [
                    BottomNavigationBarItem(
                        label: "wallet", icon: Icon(Icons.wallet, size: 35)),
                    BottomNavigationBarItem(
                        label: "home", icon: Icon(Icons.home, size: 35)),
                    BottomNavigationBarItem(
                        label: "profile", icon: Icon(Icons.person, size: 35)),
                  ],
                ),

  );
            } else {
              return const AuthWidget();
            }
          },
        ),
      ),
    );
  }
}

class RewardWidget extends StatelessWidget {
  const RewardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = RewardState();
    return ChangeNotifierProvider.value(
      value: state,
      child: const RewardView(),
    );
  }
}
