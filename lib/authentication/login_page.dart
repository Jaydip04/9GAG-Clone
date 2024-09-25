import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:gagclone/authentication/services/firebase_auth_services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../common/toast.dart';
import '../services/authService.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final FirebaseAuthServices _auth = FirebaseAuthServices();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isButtonEnabled = false;
  bool _isSigning = false;
  bool _isLoading = false;

  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      setState(() {
        _isButtonEnabled = _passwordController.text.isNotEmpty;
      });
    });
  }

  // Future<User?> signInWithApple() async {
  //   final appleCredential = await SignInWithApple.getAppleIDCredential(
  //     scopes: [
  //       AppleIDAuthorizationScopes.email,
  //       AppleIDAuthorizationScopes.fullName,
  //     ],
  //   );
  //
  //   final oauthCredential = OAuthProvider("apple.com").credential(
  //     idToken: appleCredential.identityToken,
  //     accessToken: appleCredential.authorizationCode,
  //   );
  //
  //   return await FirebaseAuth.instance.signInWithCredential(oauthCredential).then((value) => value.user);
  // }
  // Future<UserCredential> signInWithFacebook() async {
  //   final LoginResult result = await FacebookAuth.instance.login();
  //
  //   if (result.status == LoginStatus.success) {
  //     final OAuthCredential facebookAuthCredential =
  //     FacebookAuthProvider.credential(result.accessToken!.token);
  //
  //     return await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  //   } else {
  //     throw FirebaseAuthException(
  //       code: 'ERROR_ABORTED_BY_USER',
  //       message: result.message,
  //     );
  //   }
  // }
  User? user;

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
        height: MediaQuery.sizeOf(context).height,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Container(
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async{
                    try {
                      // UserCredential userCredential = await signInWithFacebook();
                      // print('Logged in as ${userCredential.user?.displayName}');
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
                      // final userCredential = await signInWithApple();
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
                      _isLoading = true;
                    });

                    String email = _emailController.text;
                    String password = _passwordController.text;

                    if(email.isEmpty){
                      showToast(message: "Email is empty");
                    }else if(password.isEmpty){
                      showToast(message: "Password is empty");
                    }else{
                      // user = await  _auth.signInWithEmailAndPAssword(email, password);
                      final result  = await _authService.login(
                        _emailController.text,
                        _passwordController.text,
                      );

                      if (result != null) {
                        final token = result['token'];
                        final userId = result['userId'];

                        Navigator.push(context, MaterialPageRoute(builder: (_) => Thank_you()));
                      } else {
                        showToast(message: "something wrong");
                      }
                      setState(() {
                        _isSigning = false;
                        _isLoading = false;
                      });

                      // if (user != null) {
                      //   // showToast(message: "User is successfully signed in");
                      //   Navigator.push(context, MaterialPageRoute(builder: (_) => Thank_you()));
                      //   // Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                      // } else {
                      //   showToast(message: "some error occured");
                      // }
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                      color: _passwordController.text.isEmpty ? Colors.indigo.shade200 : Colors.indigo,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: _isLoading ? CircularProgressIndicator(color: Colors.white,strokeWidth: 4.0,) : Text("Log in",style: commonTextStyle(Colors.white, FontWeight.bold, 16.00, null),),
                    ),
                  ),
                ),
                SizedBox(height: 20.00,),
                Text("Forgot password?",style: commonTextStyle(Colors.black, FontWeight.bold, 14.00, null),)
              ],
            ),
          ),
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
        // showToast(message: "User is successfully signed in");
        Navigator.push(context, MaterialPageRoute(builder: (_) => Thank_you()));
        // Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
      }

    }catch(e) {
      showToast(message: "some error occured $e");
    }


  }
}
class Thank_you extends StatefulWidget {
  const Thank_you({super.key});

  @override
  State<Thank_you> createState() => _Thank_youState();
}

class _Thank_youState extends State<Thank_you> {

  @override
  void initState() {
    Future.delayed(
        const Duration(seconds: 3),(){
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    }
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child:  Lottie.asset("assets/lottie_file/login.json"),
        ),
      ),
    );
  }
}
