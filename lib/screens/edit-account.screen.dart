import 'package:boba_time/components/components.dart';
import 'package:boba_time/constants/constants.dart';
import 'package:boba_time/controllers/controllers.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditAccountScreen extends StatefulWidget {
  @override
  _EditAccountScreenState createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  TextEditingController _nameEditingController;
  TextEditingController _bioEditingController = TextEditingController();

  UserController _userController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameEditingController =
        TextEditingController(text: _userController.firestoreUser.value.name);
    _bioEditingController =
        TextEditingController(text: _userController.firestoreUser.value.bio);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Edit Profile',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
              fontFamily: "PollyRounded"),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            _editProfilePhoto(
                imageUrl: _userController.firestoreUser.value.photoUrl),
            SizedBox(
              height: 50,
            ),
            _editField(
                fieldName: 'Name',
                textEditingController: _nameEditingController),
            SizedBox(
              height: 20,
            ),
            _editField(
                fieldName: 'Bio',
                textEditingController: _bioEditingController,
                maxLines: 4),
            SizedBox(
              height: 20,
            ),
            _updateButton()
          ],
        ),
      ),
    );
  }

  Widget _editProfilePhoto({imageUrl = 'https://via.placeholder.com/400x400'}) {
    return Center(
      child: Column(
        children: [
          ProfileImageComponent(imageUrl: imageUrl),
          SizedBox(
            height: 10,
          ),
          Text(
            'Change Profile Photo',
            style: TextStyle(
                color: AppThemes.bobaGreen,
                fontSize: 12,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget _editField(
      {@required String fieldName,
      @required TextEditingController textEditingController,
      maxLines = 1}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              fieldName,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppThemes.blackPearl,
                  fontSize: 14),
            ),
          ),
          flex: 1,
        ),
        Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                  controller: textEditingController,
                  maxLines: maxLines,
                  style: TextStyle(
                      color: AppThemes.blackPearl,
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                  decoration: new InputDecoration(
                      fillColor: Colors.grey[400],
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.all(8))),
            ))
      ],
    );
  }

  Widget _updateButton() {
    return FlatButton(
        color: AppThemes.bobaGreen,
        textColor: Colors.white,
        onPressed: () => _updateUserInformation(),
        child: Text('Update Information'));
  }

  void _updateUserInformation() {
    final String newName = _nameEditingController.value.text;
    final String newBio = _bioEditingController.value.text;

    dynamic updateInformation = {'name': newName, 'bio': newBio};

    // Check that the bio is less than 150 characters
    if (newBio.length > 150) {
      print('a');
      Flushbar(
        message: "Bio must be less than 150 characters",
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      )..show(Get.context);
    } else {
      try {
        _userController
            .updateFirstoreUser(
                updateInformation, _userController.firebaseUser.value.uid)
            .then((value) {
          Flushbar(
            message: "Account Updated!",
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          )..show(Get.context);
        });
      } catch (e) {
        print(e);
      }
    }
  }
}
