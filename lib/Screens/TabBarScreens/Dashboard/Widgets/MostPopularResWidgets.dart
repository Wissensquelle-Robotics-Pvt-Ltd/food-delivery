import 'package:flutter/material.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/Helper/SharedManaged.dart';
import 'package:product/ModelClass/Dashboard.dart';
import 'package:product/Screens/AllRestaurantList/AllRestaurantList.dart';
import 'package:product/Screens/RestaurantDetails/RestaurantDetails.dart';
import 'package:product/generated/i18n.dart';
import 'package:progressive_image/progressive_image.dart';

class PopularRestaurants extends StatelessWidget {
  final double width;
  final List<TopRestaurents> popularRestaurant;
  PopularRestaurants(this.width, this.popularRestaurant);
  @override
  Widget build(BuildContext context) {
    return new Container(
      width: width,
      height: 215,
      // color: AppColor.red,
      padding: new EdgeInsets.only(top: 5),
      child: new Column(
        children: <Widget>[
          Container(
            padding: new EdgeInsets.only(left: 10, right: 10),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                setCommonText(S.current.mostPopular, AppColor.black, 15.0,
                    FontWeight.w500, 1),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AllRestaurantList(
                              title: S.current.mostPopular,
                              apiKey: APIS.mostPopularRestaurant,
                              isMealDeal: false,
                            )));
                  },
                  child: Row(
                    children: [
                      setCommonText(S.current.seeAll, AppColor.black, 12.0,
                          FontWeight.w400, 1),
                      Icon(Icons.arrow_forward,
                          color: AppColor.orange, size: 16)
                    ],
                  ),
                )
              ],
            ),
          ),
          new Container(
            width: width,
            height: 180,
            // color: AppColor.red,
            child: new ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: popularRestaurant.length,
              // itemCount: 1,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context, rootNavigator: true)
                        .push(MaterialPageRoute(
                            builder: (context) => RestaurantDetails(
                                  restaurantID: popularRestaurant[index].id,
                                )));
                  },
                  child: Container(
                    width: width / 3,
                    // height: 170,
                    padding: new EdgeInsets.all(8),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          child: Column(
                            children: [
                              Expanded(flex: 1, child: Container()),
                              Expanded(
                                  flex: 5,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColor.white,
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 1,
                                            spreadRadius: 1,
                                            color: AppColor.grey[300],
                                            offset: Offset(0, 0))
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(height: 45),
                                          Text(
                                            popularRestaurant[index].name,
                                            style: TextStyle(
                                                color: AppColor.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12.0,
                                                fontFamily: SharedManager
                                                    .shared.fontFamilyName),
                                            textAlign: TextAlign.center,
                                            maxLines: 2,
                                          ),
                                          SizedBox(height: 3),
                                          Text(
                                            popularRestaurant[index].address,
                                            style: TextStyle(
                                                color: AppColor.grey,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 10.0,
                                                fontFamily: SharedManager
                                                    .shared.fontFamilyName),
                                            textAlign: TextAlign.center,
                                            maxLines: 2,
                                          ),
                                          SizedBox(height: 3),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                (popularRestaurant[index]
                                                            .review !=
                                                        null)
                                                    ? '4.2'
                                                    : '0',
                                                style: TextStyle(
                                                    color: AppColor.black87,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12.0,
                                                    fontFamily: SharedManager
                                                        .shared.fontFamilyName),
                                                textAlign: TextAlign.center,
                                                maxLines: 2,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: AppColor.orange,
                                                size: 12,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        Positioned(
                            top: 0,
                            child: Container(
                              height: 70,
                              // width: 70,
                              width: width / 4.2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 1,
                                      spreadRadius: 1,
                                      color: AppColor.grey[300],
                                      offset: Offset(0, 0))
                                ],
                                // image: DecorationImage(
                                //     fit: BoxFit.cover,
                                //     image: NetworkImage(
                                //         popularRestaurant[index].image)),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: ProgressiveImage(
                                  fit: BoxFit.cover,
                                  placeholder: AssetImage('Assets/loading.gif'),
                                  // size: 1.87KB
                                  thumbnail: AssetImage('Assets/loading.gif'),
                                  // size: 1.29MB
                                  image: NetworkImage(
                                      popularRestaurant[index].image),
                                  height: 70,
                                  width: 100,
                                ),
                              ),
                            )),
                      ],
                    ),
                    // child:
                    //  Stack(
                    //   children: <Widget>[
                    //     new Material(
                    //       color: AppColor.white,
                    //       elevation: 1.0,
                    //       borderRadius: new BorderRadius.circular(8),
                    //       child: new Column(
                    //         children: <Widget>[
                    //           new Expanded(
                    //             flex: 2,
                    //             child: new Hero(
                    //               tag: "popular$index",
                    //               child: Stack(
                    //                 children: <Widget>[
                    //                   new Container(
                    //                     decoration: BoxDecoration(
                    // image: DecorationImage(
                    //   image: NetworkImage(
                    //       popularRestaurant[index]
                    //           .image),
                    //                           fit: BoxFit.cover,
                    //                         ),
                    //                         borderRadius: BorderRadius.only(
                    //                             topLeft: Radius.circular(8),
                    //                             topRight: Radius.circular(8))),
                    //                   ),
                    //                   Container(
                    //                     decoration: BoxDecoration(
                    //                         color:
                    //                             AppColor.black.withOpacity(0.5),
                    //                         borderRadius: BorderRadius.only(
                    //                             topLeft: Radius.circular(8),
                    //                             topRight: Radius.circular(8))),
                    //                   ),
                    //                   Positioned(
                    //                       top: 5,
                    //                       right: 5,
                    //                       child: Container(
                    //                         height: 20,
                    //                         width: 45,
                    //                         decoration: BoxDecoration(
                    //                             color: Colors.green,
                    //                             borderRadius:
                    //                                 BorderRadius.circular(10)),
                    //                         child: Row(
                    //                           mainAxisAlignment:
                    //                               MainAxisAlignment.center,
                    //                           crossAxisAlignment:
                    //                               CrossAxisAlignment.center,
                    //                           children: <Widget>[
                    //                             setCommonText(
                    //                                 (popularRestaurant[index]
                    //                                             .review !=
                    //                                         null)
                    //                                     ? '${popularRestaurant[index].review}'
                    //                                     : '0.0',
                    //                                 AppColor.white,
                    //                                 13.0,
                    //                                 FontWeight.w500,
                    //                                 1),
                    //                             Icon(
                    //                               Icons.star,
                    //                               color: AppColor.white,
                    //                               size: 12,
                    //                             ),
                    //                           ],
                    //                         ),
                    //                       )),
                    //                 ],
                    //               ),
                    //             ),
                    //           ),
                    //           new Expanded(
                    //             flex: 1,
                    //             child: new Container(
                    //               // color: AppColor.yellow,
                    //               width: width / 2.5,
                    //               child: new Container(
                    //                 padding: new EdgeInsets.only(
                    //                     left: 8, right: 8, top: 5),
                    //                 child: new Column(
                    //                   crossAxisAlignment:
                    //                       CrossAxisAlignment.start,
                    //                   children: <Widget>[
                    // setCommonText(
                    //     popularRestaurant[index].name,
                    //     AppColor.black,
                    //     14.0,
                    //     FontWeight.w600,
                    //     1),
                    //                     setCommonText(
                    //                         popularRestaurant[index].address,
                    //                         AppColor.grey,
                    //                         12.0,
                    //                         FontWeight.w600,
                    //                         2),
                    //                   ],
                    //                 ),
                    //               ),
                    //             ),
                    //           )
                    //         ],
                    //       ),
                    //     ),
                    //     (popularRestaurant[index].isAvailable == '0')
                    //         ? setRestaurantClosedWidget(
                    //             context, '${S.current.closed}')
                    //         : Text('')
                    //   ],
                    // ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
