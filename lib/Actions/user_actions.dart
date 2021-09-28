import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:weather_project/model/user_model.dart';

class UserActions {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  /*Picked Image*/
  File? imageFile;
  String? imageUrl;

  UserActions(this.firebaseAuth);

  // Sign In with email and password
  Future<User?> signIn(String email, String password) async {
    try {
      var auth = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return auth.user;
    } catch (e) {
      print(e.toString());
    }
  }

  // Sign Out
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  // check Sign In
  Future<bool> isSignedIn() async {
    var currentUser = await firebaseAuth.currentUser;
    return currentUser != null;
  }

  //get current user
  Future<User?> getCurrentUser() async {
    return await firebaseAuth.currentUser;
  }

  getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null)
      imageFile = File(pickedFile.path);

  }
  getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null)
      imageFile = File(pickedFile.path);


  }
  signUp(String email, String password,String firstName,String secondName,String phone)
  async {
    await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => {postDetailsToFirestore(firstName, secondName, phone)})
        .catchError((e) {
      Fluttertoast.showToast(msg: e!.message);

    });

  }

  postDetailsToFirestore(String firstName,String secondName,String phone,) async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = firebaseAuth.currentUser;

    final ref = FirebaseStorage.instance.ref().child('userImage').child(user!.uid + '.jpg');
    await ref.putFile(imageFile!);
    imageUrl = await ref.getDownloadURL();

    UserModel userModel = UserModel();

    //writing all the values
    userModel.email = user.email;
    userModel.uid = user.uid;
    userModel.firstName = firstName;
    userModel.secondName = secondName;
    userModel.phone = phone;

    userModel.imageUrl=imageUrl;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");
  }

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  void getLoggedInUserInfo() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
    });
  }

  updateDetailsToFirestore(String firstName,String secondName,String phone,String email,String password) async {
    // calling our firestore
    // calling our user model
    // uploading these values
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = firebaseAuth.currentUser;

    UserModel userModel = UserModel();

    //writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = firstName;
    userModel.secondName = secondName;
    userModel.phone = phone;

    final ref = FirebaseStorage.instance.ref().child('userImage').child(
        user.uid + '.jpg');
    await ref.putFile(imageFile!);
    userModel.imageUrl = await ref.getDownloadURL();

    user.updatePassword(password);
    user.updateEmail(email);

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Data has been Updated ");

  }

}
