// import 'dart:convert';
// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
// import 'package:flutter_facebook_login/flutter_facebook_login.dart';
// import 'package:http/http.dart' as http;

// class FBLoginPage extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => new _LoginPageState();
// }

// class _LoginPageState extends State<FBLoginPage> {
//   final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
//   final facebookLogin = FacebookLogin();
//   // state variable to store profile data
//   var _fbUser;

//   // onPressed handler for FacebookSignInButton
//   Future<dynamic> _handleSignIn() async {
//     // facebookLogin.logIn() redirects user to login webview of Facebook (using default browser)
//     final result = await facebookLogin.logIn(['email']);
//     log('result ${result.status}');
//     try {
//       final token = result.accessToken.token;

//       log('token FB: $token');
//       final graphResponse = await http.get(
//           'https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
//       final profile = json.decode(graphResponse.body);

//       setState(() {
//         _fbUser = profile;
//       });
//     } catch (e) {
//       log('error FB log ${e.toString()}');
//     }
//   }

//   Widget renderButton() {
//     return Center(
//       child: FacebookSignInButton(
//         onPressed: this._handleSignIn,
//         textStyle: TextStyle(
//           fontSize: 14,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }

//   Widget renderUser() {
//     return Center(
//       child: Column(
//         // to center vertically
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//               height: 200,
//               width: 200,
//               child: Card(
//                   child: Image.network(
//                       _fbUser["picture"]["data"]["url"].toString(),
//                       fit: BoxFit.cover))),
//           Container(
//             padding: EdgeInsets.only(top: 20),
//             child: Column(
//               children: [
//                 Text('Name: ${_fbUser["name"]}'),
//                 Text('Email: ${_fbUser["email"]}'),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     // render button if user data is not available, else render retrieved user profile data
//     var render = _fbUser == null ? renderButton() : renderUser();
//     return new Scaffold(
//       appBar: new AppBar(
//         title: new Text('Facebook Login'),
//       ),
//       body: new Container(
//         child: render,
//       ),
//     );
//   }
// }
