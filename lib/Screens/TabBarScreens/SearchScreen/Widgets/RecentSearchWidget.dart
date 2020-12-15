import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/ModelClass/ModelSearchResult.dart';
import 'package:product/Screens/RestaurantDetails/RestaurantDetails.dart';

class RecentSearchWidget extends StatelessWidget {
  final List<MealDeal> meals;
  RecentSearchWidget(this.meals);
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: meals.length > 0 ? (meals.length * 120.0) : 0,
      padding: new EdgeInsets.all(15),
      child:
          new Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
              Widget>[
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            setCommonText('Meals', AppColor.black, 15.0, FontWeight.w500, 1),
            // setCommonText('See All', AppColor.themeColor, 15.0, FontWeight.w500, 1)
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: new Container(
            // color: AppColor.grey[100],
            child: new ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: meals.length,
              itemBuilder: (context, index) {
                return new InkWell(
                  onTap: () {
                    Navigator.of(context, rootNavigator: true)
                        .push(MaterialPageRoute(
                            builder: (context) => RestaurantDetails(
                                  restaurantID: meals[index].id,
                                )));
                  },
                  child: new Container(
                    padding: new EdgeInsets.only(
                        left: 5, right: 5, top: 5, bottom: 5),
                    child: new Material(
                      // color: AppColor.teal,
                      borderRadius: new BorderRadius.circular(5),
                      elevation: 2.0,
                      child: new Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 85,
                              width: 85,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(meals[index].image),
                                      fit: BoxFit.cover),
                                  borderRadius: new BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      bottomLeft: Radius.circular(5))),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            flex: 5,
                            child: new Container(
                              padding: new EdgeInsets.all(8),
                              // color: AppColor.pink,
                              child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  setCommonText(meals[index].name,
                                      AppColor.black, 14.0, FontWeight.w500, 1),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  setCommonText(meals[index].restaurantName,
                                      AppColor.grey, 12.0, FontWeight.w400, 3),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  new Row(
                                    children: <Widget>[
                                      new Stack(
                                        alignment: Alignment.center,
                                        children: <Widget>[
                                          setCommonText(
                                              '${Currency.curr}${meals[index].price}',
                                              AppColor.grey,
                                              12.0,
                                              FontWeight.w500,
                                              3),
                                          new Container(
                                              height: 2,
                                              width: 50,
                                              color: AppColor.black54)
                                        ],
                                      ),
                                      SizedBox(width: 5),
                                      setCommonText(
                                          '${Currency.curr}${(double.parse(meals[index].price) - double.parse(meals[index].discount))}',
                                          AppColor.black87,
                                          12.0,
                                          FontWeight.w500,
                                          3),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        )
      ]),
      // color: AppColor.red,
    );
  }
}
