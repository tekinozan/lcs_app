import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:lcs_app/components/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'auth_state.dart';
class AuthView extends StatefulWidget {
  const AuthView({
    Key? key,
  }) : super(key: key);

  @override
  State<AuthView> createState() => _AuthViewState();
}
class _AuthViewState extends State<AuthView> {

  Widget build(BuildContext context) {
    final state = Provider.of<AuthState>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
        body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
        color: HexColor("#1C1C3C")
    ),
      child:SingleChildScrollView(
    child: Padding(
    padding: const EdgeInsets.all(16.0),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset("asset/logo.png"),
            const SizedBox(height: 20),
            if (state.signInState == SignInState.signup) Text('Register', style:TextStyle(color: HexColor("#FFDE69"),fontSize: 40)),
            if (state.signInState == SignInState.login) Text('Login', style:TextStyle(color: HexColor("#FFDE69"),fontSize: 40)),
            const SizedBox(height: 10),
            if (state.signInState == SignInState.signup)
              CustomTextField(
                label: 'Name',
                controller: state.nameController,
              ),
            const SizedBox(height: 10),
            CustomTextField(
              label: 'Email',
              controller: state.emailController,
            ),
            const SizedBox(height: 10),
            CustomTextField(
              label: 'Password must be 6 character',
              controller: state.passwordController,
            ),
            const SizedBox(height: 16 * 2),
            state.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : TextButton(
                    onPressed: () async {
                      state.signUpLogin();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        state.signInState == SignInState.signup ? 'Create Account' : 'Login',
                        style: const TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w700),
                      ),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: HexColor("#FFDE69"),
                    ),
                  ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    if (state.signInState == SignInState.login) {
                      state.changeState = SignInState.signup;
                    } else {
                      state.changeState = SignInState.login;
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      state.signInState != SignInState.signup ? 'Register' : 'Login',
                      style: const TextStyle(color: Colors.amber, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),),
      ),),
    );
  }
}

class AuthWidget extends StatelessWidget {
  const AuthWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = AuthState();
    return ChangeNotifierProvider.value(
      value: state,
      child: const AuthView(),
    );
  }
}
