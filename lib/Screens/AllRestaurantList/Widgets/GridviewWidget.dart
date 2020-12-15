import 'package:flutter/material.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/ModelClass/ModelAllRestaurantList.dart';
import 'package:product/Screens/RestaurantDetails/RestaurantDetails.dart';
import 'package:product/generated/i18n.dart';

class GridViewWidgets extends StatelessWidget {
  final List<Restaurant> restaurants;
  GridViewWidgets(this.restaurants);

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.all(5),
      child: GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 0.8,
        children: new List<Widget>.generate(restaurants.length, (index) {
          return new InkWell(
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                  builder: (context) => RestaurantDetails(
                        restaurantID: restaurants[index].id,
                      )));
            },
            child: new Container(
              color: Colors.white,
              padding: new EdgeInsets.all(5),
              child: Stack(
                children: <Widget>[
                  new Container(
                    decoration: BoxDecoration(
                        borderRadius: new BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 1,
                              spreadRadius: 1,
                              offset: Offset(0, 0),
                              color: AppColor.grey[300])
                        ]),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                            flex: 2,
                            child: new Stack(
                              children: <Widget>[
                                new Container(
                                  // color: Colors.red,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              restaurants[index].image),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          topRight: Radius.circular(8))),
                                ),
                                new Container(
                                  // color: Colors.red,
                                  decoration: BoxDecoration(
                                      color: AppColor.black.withOpacity(0.4),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          topRight: Radius.circular(8))),
                                ),
                                Positioned(
                                    top: 5,
                                    right: 5,
                                    child: Container(
                                      height: 20,
                                      width: 45,
                                      decoration: BoxDecoration(
                                          color: AppColor.themeColor,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          setCommonText(
                                              (restaurants[index].review !=
                                                      null)
                                                  ? '${restaurants[index].review}'
                                                  : '0.0',
                                              AppColor.white,
                                              12.0,
                                              FontWeight.w500,
                                              1),
                                          Icon(
                                            Icons.star,
                                            color: AppColor.white,
                                            size: 12,
                                          ),
                                        ],
                                      ),
                                    ))
                              ],
                            )),
                        new Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(5),
                                    bottomLeft: Radius.circular(5))),
                            width: 300,
                            padding: new EdgeInsets.only(
                                left: 3, right: 3, bottom: 2, top: 2),
                            child: _setCommonWidgets(12.0, 10.0, 10.0, 10.0, 13,
                                restaurants[index])),
                      ],
                    ),
                  ),
                  (restaurants[index].isAvailable == '0')
                      ? setRestaurantClosedWidget(
                          context, '${S.current.closed}')
                      : Text('')
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

_setCommonWidgets(double titlFont, double descriptionFont, double ratingFont,
    double priceFont, double rationIconSize, Restaurant restaurant) {
  return new Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      setCommonText(
          restaurant.name, Colors.black, titlFont, FontWeight.w500, 1),
      SizedBox(height: 3),
      setCommonText(restaurant.address, Colors.grey[700], descriptionFont,
          FontWeight.w400, 2)
    ],
  );
}
