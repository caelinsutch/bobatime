import 'package:boba_time/constants/constants.dart';
import 'package:boba_time/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountScreen extends StatelessWidget {
  final AuthController _authController = Get.find();
  final bool _isUsersAccount = true;

  int _postCount = 0;
  int _followerCount = 0;
  int _followingCount = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[topSection()],
    );
  }

  Widget topSection() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // Image
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      'https://via.placeholder.com/400x400',
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: _accountStats(
                    followerCount: _followerCount,
                    followingCount: _followingCount,
                    postCount: _postCount),
                flex: 2,
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text('Bio'),
          SizedBox(
            height: 20,
          ),
          _accountActions(isCurrentUser: _isUsersAccount)
        ],
      ),
    );
  }

  Widget _accountActions({@required isCurrentUser}) {
    return isCurrentUser
        ? Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: OutlineButton(
                  child: Text(
                    'Edit Profile',
                    style: TextStyle(fontSize: 12),
                  ),
                  padding: EdgeInsets.all(0),
                  onPressed: () => print('Pressed'),
                  borderSide: BorderSide(
                    color: Get.theme.primaryColor, //Color of the border
                    style: BorderStyle.solid, //Style of the border
                    width: 2, //width of the border
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: FlatButton(
                    child: Text(
                      'Log Out',
                      style: TextStyle(fontSize: 12),
                    ),
                    padding: EdgeInsets.all(0),
                    textColor: Colors.white,
                    color: AppThemes.bobaGreen,
                    onPressed: () => _authController.signOut()),
              ),
            ],
          )
        : Container();
  }

  Widget _accountStats(
      {@required postCount,
      @required followerCount,
      @required followingCount}) {
    assert(postCount >= 0 && followerCount >= 0 && followingCount >= 0);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _accountStat(number: postCount, metric: 'Posts'),
        _accountStat(number: followerCount, metric: 'Followers'),
        _accountStat(number: followingCount, metric: 'Following'),
      ],
    );
  }

  Widget _accountStat({@required int number, @required String metric}) {
    return Column(
      children: [
        Text(
          number.toString(),
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppThemes.blackPearl,
              fontSize: 16),
        ),
        Text(
          metric,
          style: TextStyle(fontSize: 10),
        )
      ],
    );
  }
}
