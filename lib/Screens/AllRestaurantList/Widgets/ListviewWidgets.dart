import 'package:flutter/material.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/ModelClass/ModelAllRestaurantList.dart';
import 'package:product/Screens/BannerDetailsScreen/BannerDetailsScreen.dart';
import 'package:product/generated/i18n.dart';

class ListViewWidget extends StatelessWidget {
  final List<Restaurant> restaurants;
  ListViewWidget(this.restaurants);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: restaurants.length,
      itemBuilder: (context, index) {
        return new InkWell(
          onTap: () {
            if (restaurants[index].isAvailable == '1') {
              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                  builder: (context) => BannerDetailsScreen(
                        restaurantID: restaurants[index].id,
                      )));
            } else {
              commonRestaurantCloseAlert(context);
            }
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
                    padding: const EdgeInsets.only(
                        right: 0.0, left: 10.0, top: 8, bottom: 8),
                    child: Stack(
                      children: <Widget>[
                        new Container(
                          width: 70,
                          height: 60,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(restaurants[index].image),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Container(
                          width: 80,
                          child: (restaurants[index].isAvailable == '0')
                              ? setRestaurantClosedWidget(
                                  context, '${S.current.closed}')
                              : Text(''),
                        )
                      ],
                    ),
                  ),
                  new Expanded(
                      child: new Container(
                    // color: AppColor.red,
                    padding: new EdgeInsets.only(left: 0, top: 10, right: 5),
                    child: Stack(
                      children: <Widget>[
                        _setCommonWidgets(
                            14.0, 12.0, 12.0, 12.0, 15, restaurants[index]),
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
          FontWeight.w400, 2),
      SizedBox(
        height: 3,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          setCommonText(
              (restaurant.review != null) ? '${restaurant.review}' : '0.0',
              AppColor.orange,
              13.0,
              FontWeight.w500,
              1),
          Icon(
            Icons.star,
            color: AppColor.orange,
            size: 12,
          ),
        ],
      ),
    ],
  );
}
