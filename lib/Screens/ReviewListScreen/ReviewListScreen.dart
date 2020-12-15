import 'package:flutter/material.dart';
import 'package:product/BlocClass/MainModelBlocClass/RestaurantReviewsBLoC.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/ModelClass/ModelAllReviewList.dart';

class ReviewListScreen extends StatefulWidget {
  final String restaurantId;
  final String restaurantName;
  ReviewListScreen({this.restaurantId, this.restaurantName});

  @override
  _ReviewListScreenState createState() => _ReviewListScreenState();
}

class _ReviewListScreenState extends State<ReviewListScreen> {
  @override
  void initState() {
    super.initState();
    restaurantReviewsBloc.fetchRestaurantReviews(this.widget.restaurantId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColor.themeColor,
        title: setCommonText('${this.widget.restaurantName}', AppColor.white,
            20.0, FontWeight.w500, 1),
      ),
      body: StreamBuilder(
          stream: restaurantReviewsBloc.restaurantReviews,
          builder: (context, AsyncSnapshot<ResAllReview> snapshot) {
            if (snapshot.hasData) {
              final List<AllReviews> review = snapshot.data.reviews;
              return Container(
                child: new ListView.builder(
                    itemCount: review.length,
                    itemBuilder: (context, index) {
                      return new Container(
                        padding: EdgeInsets.only(left: 12, right: 12),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 60,
                              child: new Row(
                                children: <Widget>[
                                  Expanded(
                                      flex: 2,
                                      child: Container(
                                        child: Center(
                                          child: CircleAvatar(
                                            radius: 22,
                                            backgroundImage: NetworkImage(
                                                review[index].userImage),
                                          ),
                                        ),
                                      )),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                      // color: Colors.green,
                                      child: new Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          setCommonText(
                                              '${review[index].userName}',
                                              AppColor.black87,
                                              16.0,
                                              FontWeight.w500,
                                              1),
                                          setCommonText(
                                              '${review[index].city}',
                                              AppColor.grey[700],
                                              13.0,
                                              FontWeight.w400,
                                              2),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 3,
                                      child: Container(
                                        // color:Colors.blue,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                setCommonText(
                                                  (review[index].review != null)
                                                      ? review[index].review
                                                      : '0.0',
                                                  AppColor.black,
                                                  16.0,
                                                  FontWeight.bold,
                                                  1,
                                                ),
                                                Icon(Icons.star,
                                                    color: AppColor.orange,
                                                    size: 17)
                                              ],
                                            ),
                                            setCommonText(
                                              '${review[index].date}',
                                              AppColor.grey[700],
                                              13.0,
                                              FontWeight.w400,
                                              1,
                                            ),
                                          ],
                                        ),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            setCommonText(
                              '${review[index].message}',
                              AppColor.black87,
                              14.0,
                              FontWeight.w400,
                              10,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(color: AppColor.grey),
                          ],
                        ),
                      );
                    }),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
