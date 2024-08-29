import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:gagclone/authentication/services/firebase_auth_services.dart';
import 'package:gagclone/pages/home_page.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../common/toast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _isSigning = false;
  final FirebaseAuthServices _auth = FirebaseAuthServices();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      setState(() {
        _isButtonEnabled = _emailController.text.isNotEmpty;
      });
    });
    _passwordController.addListener(() {
      setState(() {
        _isButtonEnabled = _passwordController.text.isNotEmpty;
      });
    });
  }

  Future<User?> signInWithApple() async {
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
    );

    return await FirebaseAuth.instance.signInWithCredential(oauthCredential).then((value) => value.user);
  }
  Future<UserCredential> signInWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      final OAuthCredential facebookAuthCredential =
      FacebookAuthProvider.credential(result.accessToken!.token);

      return await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    } else {
      throw FirebaseAuthException(
        code: 'ERROR_ABORTED_BY_USER',
        message: result.message,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.xmark,
            color: Colors.grey,
            size: 22,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Login",
          style: commonTextStyle(Colors.black, FontWeight.bold, 18.00, null),
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async{
                try {
                  UserCredential userCredential = await signInWithFacebook();
                  print('Logged in as ${userCredential.user?.displayName}');
                } catch (e) {
                  print(e);
                }
              },
              child: Container(
                margin: EdgeInsets.symmetric(

                    vertical: 5.0),
                width: double.infinity,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                    color: Colors.grey
                        .withOpacity(0.3),
                    width: 1,
                  ),
                  borderRadius:
                  BorderRadius.circular(26),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.only(
                          left: 10),
                      child: Image.asset(
                        "assets/logo/facebook.png",
                        width: 24,
                        height: 24,
                      ),
                    ),
                    SizedBox(
                      width: 70,
                    ),
                    Text(
                      "Continue with Facebook",
                      style: commonTextStyle(
                          Colors.black,
                          FontWeight.bold,
                          16.0,
                          null),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                _signInWithGoogle();
              },
              child: Container(
                margin: EdgeInsets.symmetric(

                    vertical: 5.0),
                width: double.infinity,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                    color: Colors.grey
                        .withOpacity(0.3),
                    width: 1,
                  ),
                  borderRadius:
                  BorderRadius.circular(26),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.only(
                          left: 10),
                      child: Image.asset(
                        "assets/logo/google.png",
                        width: 24,
                        height: 24,
                      ),
                    ),
                    SizedBox(
                      width: 75,
                    ),
                    Text(
                      "Continue with Google",
                      style: commonTextStyle(
                          Colors.black,
                          FontWeight.bold,
                          16.0,
                          null),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async{
                try {
                  final userCredential = await signInWithApple();
                  // showToast(message:"Signed in as: ${userCredential.user?.displayName}", );
                } catch (e) {
                  showToast(message:"Failed to sign in with Apple: $e", );
                }
              },
              child: Container(
                margin: EdgeInsets.symmetric(
                    vertical: 5.0),
                width: double.infinity,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                    color: Colors.grey
                        .withOpacity(0.3),
                    width: 1,
                  ),
                  borderRadius:
                  BorderRadius.circular(26),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.only(
                          left: 10),
                      child: Image.asset(
                        "assets/logo/apple.png",
                        width: 24,
                        height: 24,
                      ),
                    ),
                    SizedBox(
                      width: 80,
                    ),
                    Text(
                      "Continue with Apple",
                      style: commonTextStyle(
                          Colors.black,
                          FontWeight.bold,
                          16.0,
                          null),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.0,),
            Text("or",style: commonTextStyle(Colors.grey, FontWeight.bold, 16.00, null),),
            SizedBox(height: 10.0,),
            TextFormField(
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.singleLineFormatter,
                ],
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                cursorColor: Colors.indigo,
                style: commonTextStyle(Colors.black, FontWeight.bold, 16.00, null),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                  fillColor: Colors.transparent,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                    const BorderSide(color: Color(0x1A090909), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                    const BorderSide(color: Color(0x1A090909), width: 1),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                    const BorderSide(color: Color(0x1A090909), width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                    const BorderSide(color: Color(0x1A090909), width: 1),
                  ),
                  hintText: "Username or email address",
                  hintStyle: commonTextStyle(Colors.grey, FontWeight.bold, 16.00, null),
                )),
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.singleLineFormatter,
                ],
                keyboardType: TextInputType.text,
                controller: _passwordController,
                cursorColor: Colors.indigo,
                style: commonTextStyle(Colors.black, FontWeight.bold, 16.00, null),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                  fillColor: Colors.transparent,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                    const BorderSide(color: Color(0x1A090909), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                    const BorderSide(color: Color(0x1A090909), width: 1),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                    const BorderSide(color: Color(0x1A090909), width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                    const BorderSide(color: Color(0x1A090909), width: 1),
                  ),
                  hintText: "Password",
                  hintStyle: commonTextStyle(Colors.grey, FontWeight.bold, 16.00, null),
                )),
            SizedBox(
              height: 10.0,
            ),
            GestureDetector(
              onTap: () async{
                setState(() {
                  _isSigning = true;
                });

                String email = _emailController.text;
                String password = _passwordController.text;

                if(email.isEmpty){
                  showToast(message: "Email is empty");
                }else if(password.isEmpty){
                  showToast(message: "Password is empty");
                }else{
                  User? user = await  _auth.signInWithEmailAndPAssword(email, password);
                  setState(() {
                    _isSigning = false;
                  });

                  if (user != null) {
                    showToast(message: "User is successfully signed in");
                    Navigator.of(context).push(_HomeRoute());
                  } else {
                    showToast(message: "some error occured");
                  }
                }
              },
              child: Container(
                width: double.infinity,
                height: 45,
                decoration: BoxDecoration(
                  color: _emailController.text.isEmpty && _passwordController.text.isEmpty ? Colors.indigo.shade200 : Colors.indigo,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text("Log in",style: commonTextStyle(Colors.white, FontWeight.bold, 16.00, null),),
                ),
              ),
            ),
            SizedBox(height: 20.00,),
            Text("Forgot password?",style: commonTextStyle(Colors.black, FontWeight.bold, 14.00, null),)
          ],
        ),
      ),
    );
  }
  TextStyle commonTextStyle(color, weight, size, decoration) {
    return TextStyle(
        color: color,
        fontWeight: weight,
        fontSize: size,
        decoration: decoration);
  }
  _signInWithGoogle()async{

    final GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

      if(googleSignInAccount != null ){
        final GoogleSignInAuthentication googleSignInAuthentication = await
        googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );
        await _firebaseAuth.signInWithCredential(credential);
        showToast(message: "User is successfully signed in");
        Navigator.of(context).push(_HomeRoute());
      }

    }catch(e) {
      showToast(message: "some error occured $e");
    }


  }
  Route _HomeRoute() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
        const HomePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          final tween = Tween(begin: begin, end: end);
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: curve,
          );

          return SlideTransition(
            position: tween.animate(curvedAnimation),
            child: child,
          );
        },
        transitionDuration: Duration(milliseconds: 1000));
  }
}
