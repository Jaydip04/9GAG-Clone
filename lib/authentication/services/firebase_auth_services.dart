import 'package:firebase_auth/firebase_auth.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../common/toast.dart';

class FirebaseAuthServices{
  FirebaseAuth _auth = FirebaseAuth.instance;
  Future<User?> signUpWithEmailAndPassword(String email,String password) async{
    try{
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email:email,password: password);
      return credential.user;
    }on FirebaseAuthException catch (e){
      if(e.code == "email-already-in-use"){
        showToast(message: "The email address is already in use.");
      }else{
        showToast(message: "An error occurred: ${e.code}");
      }
    }
    return null;
  }

  Future<User?> signInWithEmailAndPAssword(String email,String password) async{
    try{
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    }on FirebaseAuthException catch (e){
      if(e.code == 'user-not-found' || e.code == 'wrong-password'){
        showToast(message: "Invalid email or password.");
      }else{
        showToast(message: "An error occurred: ${e.code}");
      }
    }
    return null;
  }


}