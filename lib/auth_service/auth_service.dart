import 'package:api_withgetx/utills/utills.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authservices {
  /// Firebase instances
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore store = FirebaseFirestore.instance;

  /// Private fields
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  String _phone = '';
  String _firstName = '';
  String _lastName = '';

  /// Getters and Setters for user information
  String get getEmail => _email;
  set setEmail(String value) => _email = value;

  String get password => _password;
  set setPassword(String value) => _password = value;

  String get confirmPassword => _confirmPassword;
  set setConfirmPassword(String value) => _confirmPassword = value;

  String get phone => _phone;
  set setPhone(String value) => _phone = value;

  String get firstName => _firstName;
  set setFirstName(String value) => _firstName = value;

  String get lastName => _lastName;
  set setLastName(String value) => _lastName = value;

  Future<bool> signUp(String email, String phoneNumber, String password,
      BuildContext context) async {
    try {
      // Check if the email is already registered
      bool emailExists = await isEmailRegistered(email);

      if (emailExists) {
        Utils.toastMessage(
            'The account already exists for that email. Please provide another email.');
        return false; // Exit the function if email is already registered
      }

      // Create a user with email and password
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // Store additional user information in Firestore
      await store.collection("signUp").doc(userCredential.user!.uid).set({
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phone": "+91$phoneNumber",
        "password": password,
        "confirm_password": confirmPassword,
      });

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Utils.toastMessage('The password provided is too weak.');
      } else {
        Utils.toastMessage('Sign up failed: ${e.message}');
      }
      return false;
    } catch (e) {
      Utils.toastMessage('Sign up failed: $e');
      return false;
    }
  }

  Future<bool> isEmailRegistered(String email) async {
    // Query Firestore to check if the email is already registered
    try {
      QuerySnapshot querySnapshot = await store
          .collection('signUp')
          .where('email', isEqualTo: email)
          .get();
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      Utils.toastMessage('Error checking email registration: $e');
      return false;
    }
  }

  Future<bool> signIn(String email, String password) async {
    try {
      // Query Firestore to find the user document
      QuerySnapshot querySnapshot = await store
          .collection('signUp')
          .where(
            'email',
            isEqualTo: email,
          )
          .get();

      if (querySnapshot.docs.isEmpty) {
        Utils.toastMessage('No user found for that email.');
        return false;
      }

      // Assuming emails are unique, we take the first document
      var userDoc = querySnapshot.docs.first;
      var userData = userDoc.data() as Map<String, dynamic>;

      // Check if the provided password matches the stored password
      if (userData['password'] != password) {
        Utils.toastMessage('Wrong password provided for that user.');
        return false;
      }

      // Optionally, sign in using FirebaseAuth to keep the user session
      await auth.signInWithEmailAndPassword(email: email, password: password);

      return true; // Sign-in successful
    } on FirebaseAuthException catch (e) {
      Utils.toastMessage('Sign in failed: ${e.message}');
      return false; // Sign-in failed
    } catch (e) {
      Utils.toastMessage('Sign in failed: $e');
      return false; // Sign-in failed
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

  Future<bool> isLoggedIn() async {
    return auth.currentUser != null;
  }

  Future<User?> getCurrentUser() async {
    return auth.currentUser;
  }
}
