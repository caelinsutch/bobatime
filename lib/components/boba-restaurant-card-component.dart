import 'package:boba_time/components/card.component.dart';
import 'package:boba_time/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BobaRestaurantCardComponent extends StatelessWidget {
  String restaurantTitle = 'Boba 1';
  int restaurantRating = 3;

  BobaRestaurantCardComponent(
      {@required this.restaurantTitle, @required this.restaurantRating})
      : assert(restaurantRating <= 5 && restaurantRating >= 0);

  @override
  Widget build(BuildContext context) {
    return CardComponent(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              'https://via.placeholder.com/400x400',
              width: 75,
              height: 75,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            restaurantTitle,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 15,
          ),
          RatingBar(
            initialRating: 3,
            minRating: 0,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: 20,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
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
          FlatButton(
            color: AppThemes.bobaGreen,
            textColor: Colors.white,
            child: Text(
              'Get Directions',
              style: TextStyle(fontSize: 12),
            ),
            onPressed: () => print('Directions'),
          )
        ],
      ),
    );
  }
}
