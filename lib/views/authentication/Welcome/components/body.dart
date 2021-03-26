import 'package:flutter/material.dart';
import 'package:flutter_login/common/routes/fade_route.dart';
import 'package:flutter_login/common/routes/size.dart';
import 'package:flutter_login/constants.dart';
import 'package:flutter_login/views/authentication/Login/login_screen.dart';
import 'package:flutter_login/views/authentication/Signup/signup_screen.dart';
import 'package:flutter_login/views/authentication/Welcome/components/background.dart';
import 'package:flutter_login/views/authentication/components/rounded_button.dart';
import 'package:flutter_login/views/common/FadeAnimation.dart';
import 'package:lottie/lottie.dart';

import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // const Text(
            //   'WELCOME TO EDU',
            //   style: TextStyle(fontWeight: FontWeight.bold),
            // ),
            // FadeAnimation(
            //     2.5,
            //     SvgPicture.asset(
            //       'assets/icons/chat.svg',
            //       height: size.height * 0.45,
            //     )),

            FadeAnimation(
                2.5,
                Lottie.asset(
                  'assets/animations/chat.json',
                  // width: 250,
                  // height: 250,
                  fit: BoxFit.fill,
                )),
            SizedBox(height: size.height * 0.05),
            SizedBox(height: size.height * 0.05),
            SizedBox(height: size.height * 0.05),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
                text: 'LOGIN',
                press: () =>
                    Navigator.of(context).push(FadeRoute(page: LoginScreen()))),
            RoundedButton(
                text: 'SIGN UP',
                color: kPrimaryLightColor,
                textColor: Colors.black,
                press: () => Navigator.of(context)
                    .push(SizeRoute(page: SignUpScreen()))),
          ],
        ),
      ),
    );
  }
}
