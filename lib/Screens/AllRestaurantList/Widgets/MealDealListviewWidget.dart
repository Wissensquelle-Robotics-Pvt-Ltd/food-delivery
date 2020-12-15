import 'package:flutter/material.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/Screens/RestaurantDetails/RestaurantDetails.dart';
import 'package:product/ModelClass/ModelMealDeals.dart';
import 'package:product/generated/i18n.dart';
import 'package:progressive_image/progressive_image.dart';

class ListviewMealWidget extends StatelessWidget {
  final List<Result> data;
  ListviewMealWidget(this.data);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return new InkWell(
          onTap: () {
            Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                builder: (context) => RestaurantDetails(
                      restaurantID: data[index].id,
                    )));
          },
          child: new Container(
            height: 100,
            // color: Colors.red,
            width: MediaQuery.of(context).size.width,
            padding: new EdgeInsets.only(left: 8, right: 8, top: 3, bottom: 3),
            child: new Material(
              elevation: 1.0,
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              child: new Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: new Container(
                      width: 80,
                      decoration: BoxDecoration(
                          // image: DecorationImage(
                          //     image: NetworkImage(data[index].image),
                          //     fit: BoxFit.cover),
                          ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: ProgressiveImage(
                          fit: BoxFit.cover,
                          placeholder: AssetImage('Assets/loading.gif'),
                          // size: 1.87KB
                          thumbnail: AssetImage('Assets/loading.gif'),
                          // size: 1.29MB
                          image: NetworkImage(data[index].image),
                          height: 80,
                          width: 80,
                        ),
                      ),
                    ),
                  ),
                  new Expanded(
                      child: new Container(
                    padding: new EdgeInsets.only(left: 0, top: 10, right: 5),
                    child: Stack(
                      children: <Widget>[
                        _setCommonWidgetsForMealList(
                            14.0, 12.0, 12.0, 12.0, 13, data[index])
                      ],
                    ),
                  ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

_setCommonWidgetsForMealList(double titlFont, double descriptionFont,
    double ratingFont, double priceFont, double rationIconSize, Result item) {
  return new Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(height: 2),
      setCommonText(item.name, Colors.black, titlFont, FontWeight.w500, 1),
      SizedBox(height: 3),
      setCommonText(item.restaurantName, Colors.grey[700], descriptionFont,
          FontWeight.w400, 2),
      SizedBox(
        height: 3,
      ),
      new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Row(
            children: <Widget>[
              setCommonText(
                  "4.1", Colors.orange, ratingFont, FontWeight.w500, 1),
              SizedBox(width: 2),
              new Icon(
                Icons.star,
                size: rationIconSize,
                color: Colors.orange,
              ),
              SizedBox(width: 2),
              setCommonText("12 ${S.current.reviews}", Colors.grey, ratingFont,
                  FontWeight.w400, 1),
            ],
          ),
          new Row(
            children: <Widget>[
              setCommonText(
                  '${Currency.curr}${(double.parse(item.price) - (double.parse(item.discount)))}',
                  Colors.black,
                  priceFont,
                  FontWeight.w600,
                  1),
            ],
          )
        ],
      )
    ],
  );
}
