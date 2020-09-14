import 'package:boba_time/components/card.component.dart';
import 'package:boba_time/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

typedef BoolCallback(bool value);

class BobaRestaurantCardComponent extends StatelessWidget {
  String restaurantTitle = 'Boba 1';
  String restaurantImage = 'https://via.placeholder.com/400x400';
  double restaurantRating = 3;
  bool saved;
  BoolCallback onSavedSwitch;

  BobaRestaurantCardComponent(
      {@required this.restaurantTitle,
      @required this.restaurantRating,
      @required this.saved,
      @required this.onSavedSwitch,
      this.restaurantImage = 'https://via.placeholder.com/400x400'})
      : assert(restaurantRating <= 5 && restaurantRating >= 0);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 100,
      width: 175,
      decoration: BoxDecoration(
        color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              this.saved
                  ? GestureDetector(
                      onTap: () => this.onSavedSwitch(false),
                      child: Icon(Icons.bookmark),
                    )
                  : GestureDetector(
                      onTap: () => this.onSavedSwitch(true),
                      child: Icon(Icons.bookmark_border)),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              this.restaurantImage,
              width: 75,
              height: 75,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            restaurantTitle,
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10,
          ),
          RatingBar(
            initialRating: this.restaurantRating,
            minRating: 0,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: 20,
            itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (r) => null,
            tapOnlyMode: true,
          ),
          SizedBox(
            height: 15,
          ),
          ButtonTheme(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            //limits the touch area to the button area
            minWidth: 0,
            //wraps child's width
            height: 0,
            //wraps child's height
            child: FlatButton(
              padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              //adds padding inside the button
              color: AppThemes.bobaGreen,
              textColor: Colors.white,
              child: Text('Get Directions', style: TextStyle(fontSize: 12)),
              onPressed: () => print('Directions'),
            ),
          )
        ],
      ),
    );
  }
}
