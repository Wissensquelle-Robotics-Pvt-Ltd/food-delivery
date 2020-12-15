import 'package:flutter/material.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/ModelClass/ModelRestaurantDetails.dart';
import 'package:product/Screens/ReviewListScreen/ReviewListScreen.dart';
import 'package:product/generated/i18n.dart';

class ReviewWidgets extends StatelessWidget {
  final List<Reviews> reviewList;
  final String resID;
  final String resName;
  ReviewWidgets(this.reviewList, this.resID, this.resName);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (reviewList.length * 200).toDouble(),
      width: MediaQuery.of(context).size.width,
      color: AppColor.grey[100],
      padding: EdgeInsets.only(top: 12, bottom: 12),
      child: Column(
        children: <Widget>[
          setCommonText('${S.current.whatPeopleareSaying}', AppColor.black87,
              15.0, FontWeight.w500, 1),
          Divider(),
          Expanded(
              child: Container(
            color: AppColor.grey[100],
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: new ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: reviewList.length,
                  itemBuilder: (context, index) {
                    return new Container(
                      // height: 200,
                      // color: AppColor.amber,
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
                                              reviewList[index].userImage),
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
                                            '${reviewList[index].userName}',
                                            AppColor.black87,
                                            16.0,
                                            FontWeight.w500,
                                            1),
                                        setCommonText(
                                            '${reviewList[index].city}',
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
                                                (reviewList[index].review !=
                                                        null)
                                                    ? reviewList[index].review
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
                                            '${reviewList[index].date}',
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
                            '${reviewList[index].message}',
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
            ),
          )),
          Container(
            height: 85,
            padding: EdgeInsets.all(15),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ReviewListScreen(
                          restaurantId: resID,
                          restaurantName: resName,
                        ),
                    fullscreenDialog: true));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: AppColor.themeColor,
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: setCommonText('${S.current.viewMoreReviews}',
                      AppColor.white, 16.0, FontWeight.w500, 1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
