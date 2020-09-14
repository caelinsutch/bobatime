import 'dart:async';

import 'package:boba_time/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserController extends GetxController {
  static UserController to = Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Rx<FirebaseUser> firebaseUser = Rx<FirebaseUser>();
  Rx<UserModel> firestoreUser = Rx<UserModel>();
  final RxBool admin = false.obs;

  @override
  void onReady() async {
    //run every time auth state changes
    ever(firebaseUser, handleAuthChanged);
    firebaseUser.value = await getUser;
    firebaseUser.bindStream(user);
    super.onInit();
  }

  handleAuthChanged(_firebaseUser) async {
    //get user data from firestore
    if (_firebaseUser?.uid != null) {
      firestoreUser.bindStream(streamFirestoreUser());
      await isAdmin();
    }

    if (_firebaseUser == null) {
      Get.offAndToNamed('/auth');
    } else {
      if (Get.currentRoute == '/auth') {
        Get.offAndToNamed('/');
      }
    }
  }

  // Firebase user one-time fetch
  Future<FirebaseUser> get getUser => _auth.currentUser();

  // Firebase user a realtime stream
  Stream<FirebaseUser> get user => _auth.onAuthStateChanged;

  //Streams the firestore user from the firestore collection if it exists, else return nothing
  Stream<UserModel> streamFirestoreUser() {
    if (firebaseUser?.value?.uid != null) {
      return _db
          .document('/users/${firebaseUser.value.uid}')
          .snapshots()
          .map((snapshot) => UserModel.fromMap(snapshot.data));
    }

    return null;
  }

  //get the firestore user from the firestore collection if it exists, else null
  Future<UserModel> getFirestoreUser() {
    if (firebaseUser?.value?.uid != null) {
      return _db
          .document('/users/${firebaseUser.value.uid}')
          .get()
          .then((documentSnapshot) => UserModel.fromMap(documentSnapshot.data));
    }
    return null;
  }

  Future<void> signInWithGoogle() async {
    // Sign in
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    // Get credential
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser firebaseUser = authResult.user;

    assert(!firebaseUser.isAnonymous);
    assert(await firebaseUser.getIdToken() != null);

    final FirebaseUser currentFirebaseUser = await _auth.currentUser();
    assert(firebaseUser.uid == currentFirebaseUser.uid);

    final userModel = new UserModel(
        uid: firebaseUser.uid,
        email: firebaseUser.email,
        name: firebaseUser.displayName,
        photoUrl: firebaseUser.photoUrl);

    if (_db.document(firebaseUser.uid).isNullOrBlank) {
      _createFirestoreUser(userModel, currentFirebaseUser.uid);
    }
    Get.offAndToNamed('/');
  }

  void signOutGoogle() async {
    await googleSignIn.signOut();
  }

  //updates the firestore users collection
  void _createFirestoreUser(UserModel user, String firebaseUserUid) {
    _db.document('/users/$firebaseUserUid').setData(user.toMap());
    update();
  }

  Future<void> updateFirestoreUser(
      Map updateValues, String firebaseUserUid) async {
    await _db
        .document('/users/$firebaseUserUid')
        .setData(updateValues, merge: true);
    update();
    return;
  }

  Future<void> addSavedBobaPlace(
      BobaShopModel bobaShop, String firebaseUserUid) async {
    await _db
        .document('/users/$firebaseUserUid')
        .setData({'favoriteBobaShops': FieldValue.arrayUnion([bobaShop.toMap()])}, merge: true);
    update();
    return;
  }

  Future<void> removeSavedBobaPlace(
      BobaShopModel bobaShop, String firebaseUserUid) async {
    await _db
        .document('/users/$firebaseUserUid')
        .setData({'favoriteBobaShops': FieldValue.arrayRemove([bobaShop.toMap()])}, merge: true);
    update();
    return;
  }

  //check if user is an admin user
  isAdmin() async {
    await getUser.then((user) async {
      DocumentSnapshot adminRef =
          await _db.collection('admin').document(user?.uid).get();
      if (adminRef.exists) {
        admin.value = true;
      } else {
        admin.value = false;
      }
      update();
    });
  }

  // Sign out
  Future<void> signOut() {
    return _auth.signOut();
  }
}
