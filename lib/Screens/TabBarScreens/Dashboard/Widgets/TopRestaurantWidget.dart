import 'package:flutter/material.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/Helper/SharedManaged.dart';
import 'package:product/ModelClass/Dashboard.dart';
import 'package:product/Screens/AllRestaurantList/AllRestaurantList.dart';
import 'package:product/Screens/RestaurantDetails/RestaurantDetails.dart';
import 'package:product/generated/i18n.dart';
import 'package:progressive_image/progressive_image.dart';

class TopRestaurants extends StatelessWidget {
  final double width;
  final List<TopRestaurents> topRestaurant;
  TopRestaurants(this.width, this.topRestaurant);

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: width,
      height: 160,
      // color: AppColor.red[100],
      padding: new EdgeInsets.only(top: 0),
      child: new Column(
        children: <Widget>[
          Container(
            padding: new EdgeInsets.only(left: 10, right: 10),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                setCommonText(S.current.topRestaurants, AppColor.black, 14.0,
                    FontWeight.w600, 1),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AllRestaurantList(
                              title: S.current.topRestaurants,
                              apiKey: APIS.allTopRestaurant,
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
            height: 130,
            // color: Colors.red,
            child: new ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: topRestaurant.length,
              // itemCount: 1,
              itemBuilder: (context, index) {
                return new GestureDetector(
                  onTap: () {
                    Navigator.of(context, rootNavigator: true)
                        .push(MaterialPageRoute(
                            builder: (context) => RestaurantDetails(
                                  restaurantID: topRestaurant[index].id,
                                )));
                  },
                  child: new Container(
                    width: width / 1.6,
                    padding: new EdgeInsets.all(8),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 2,
                              spreadRadius: 0,
                              color: AppColor.grey,
                              offset: Offset(0, 0))
                        ],
                        color: AppColor.white,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                              child: Container(
                            // color: AppColor.red,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    // image: DecorationImage(
                                    //     fit: BoxFit.cover,
                                    //     image: NetworkImage(
                                    //         topRestaurant[index].image))
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(40),
                                    child: ProgressiveImage(
                                      fit: BoxFit.cover,
                                      placeholder:
                                          AssetImage('Assets/loading.gif'),
                                      // size: 1.87KB
                                      thumbnail:
                                          AssetImage('Assets/loading.gif'),
                                      // size: 1.29MB
                                      image: NetworkImage(
                                          topRestaurant[index].image),
                                      height: 80,
                                      width: 80,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )),
                          Expanded(
                              child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                setCommonText('${topRestaurant[index].name}',
                                    AppColor.black, 12.0, FontWeight.w500, 2),
                                SizedBox(height: 5),
                                setCommonText('${topRestaurant[index].address}',
                                    AppColor.grey, 10.0, FontWeight.w400, 2),
                                SizedBox(height: 3),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      '4.2',
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
                          )),
                        ],
                      ),
                    ),
                    // child:
                    // Stack(
                    //   children: <Widget>[
                    //     new Material(
                    //       color: AppColor.white,
                    //       elevation: 1.0,
                    //       borderRadius: new BorderRadius.circular(8),
                    //       child: new Column(
                    //         children: <Widget>[
                    //           new Expanded(
                    //             flex: 2,
                    //             child: Stack(
                    //               children: <Widget>[
                    //                 new Container(
                    //                   decoration: BoxDecoration(
                    //                       image: DecorationImage(
                    // image: NetworkImage(
                    //     topRestaurant[index].image),
                    //                         fit: BoxFit.cover,
                    //                       ),
                    //                       borderRadius:
                    //                           BorderRadius.circular(8)),
                    //                 ),
                    //                 Container(
                    //                   height: 150,
                    //                   decoration: BoxDecoration(
                    //                       color:
                    //                           AppColor.black.withOpacity(0.5),
                    //                       borderRadius:
                    //                           BorderRadius.circular(8)),
                    //                 ),
                    //                 Positioned(
                    //                     top: 8,
                    //                     right: 0,
                    //                     child: Container(
                    //                       height: 20,
                    //                       width: 45,
                    //                       decoration: BoxDecoration(
                    //                           color: AppColor.amber.shade700,
                    //                           borderRadius: BorderRadius.only(
                    //                               topLeft: Radius.circular(10),
                    //                               bottomLeft:
                    //                                   Radius.circular(10))),
                    //                       child: Row(
                    //                         mainAxisAlignment:
                    //                             MainAxisAlignment.center,
                    //                         crossAxisAlignment:
                    //                             CrossAxisAlignment.center,
                    //                         children: <Widget>[
                    //                           setCommonText(
                    //                               (topRestaurant[index]
                    //                                           .review !=
                    //                                       null)
                    //                                   ? '${topRestaurant[index].review}'
                    //                                   : '0.0',
                    //                               AppColor.white,
                    //                               13.0,
                    //                               FontWeight.w500,
                    //                               1),
                    //                           Icon(
                    //                             Icons.star,
                    //                             color: AppColor.white,
                    //                             size: 12,
                    //                           ),
                    //                         ],
                    //                       ),
                    //                     ))
                    //               ],
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //     (topRestaurant[index].isAvailable == '0')
                    //         ? setRestaurantClosedWidget(context, 'Closed')
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
