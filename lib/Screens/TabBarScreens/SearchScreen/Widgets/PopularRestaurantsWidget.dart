import 'package:flutter/material.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/ModelClass/ModelSearchResult.dart';
import 'package:product/Screens/BannerDetailsScreen/BannerDetailsScreen.dart';

class PopularRestaurantWidget extends StatelessWidget {
  final List<Restaurents> restaurants;
  PopularRestaurantWidget(this.restaurants);

  @override
  Widget build(BuildContext context) {
    return new Container(
      height:
          (restaurants.length > 0) ? MediaQuery.of(context).size.width / 2 : 0,
      // color: AppColor.red,
      padding: new EdgeInsets.all(15),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              setCommonText('Popular Restaurant', AppColor.black, 15.0,
                  FontWeight.w500, 1),
              // setCommonText('See All', AppColor.themeColor, 15.0, FontWeight.w500, 1)
            ],
          ),
          SizedBox(
            height: 10,
          ),
          new Expanded(
            child: new Container(
              child: new ListView.builder(
                itemCount: restaurants.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return new InkWell(
                    onTap: () {
                      Navigator.of(context, rootNavigator: true)
                          .push(MaterialPageRoute(
                              builder: (context) => BannerDetailsScreen(
                                    restaurantID: restaurants[index].id,
                                  )));
                    },
                    child: new Container(
                      padding: new EdgeInsets.all(4),
                      width: MediaQuery.of(context).size.width / 3,
                      child: new Material(
                          color: AppColor.grey[100],
                          elevation: 2.0,
                          borderRadius: new BorderRadius.circular(5),
                          child: new Container(
                            // padding: new EdgeInsets.all(4),
                            child: new Column(
                              children: <Widget>[
                                new Expanded(
                                  child: new Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              restaurants[index].image),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: new BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5))),
                                  ),
                                ),
                                Container(
                                  padding: new EdgeInsets.all(4),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Text(
                                        restaurants[index].name,
                                        style: new TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                        // maxLines: 2,
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      new Text(
                                        restaurants[index].address,
                                        style: new TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.grey),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
