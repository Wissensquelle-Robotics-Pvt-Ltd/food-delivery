import 'package:flutter/material.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/ModelClass/Dashboard.dart';
import 'package:product/Screens/BannerDetailsScreen/BannerDetailsScreen.dart';

class BottomBannerWidget extends StatelessWidget {
  final List<BannerRestaurent> bannerData;
  final PageController pageControll;
  final index;
  BottomBannerWidget(this.bannerData, this.pageControll, this.index);
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pageControll,
      builder: (BuildContext context, Widget widget) {
        double value = 1;
        if (pageControll.position.haveDimensions) {
          value = pageControll.page - index;
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 125.0,
            width: Curves.easeInOut.transform(value) * 350.0,
            child: widget,
          ),
        );
      },
      child: InkWell(
          onTap: () {
            //moveCamera();
            Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                builder: (context) => BannerDetailsScreen(
                      restaurantID: bannerData[index].id,
                    )));
          },
          child: Stack(children: [
            Center(
                child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 20.0,
                    ),
                    height: 125.0,
                    width: 275.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            offset: Offset(0.0, 4.0),
                            blurRadius: 10.0,
                          ),
                        ]),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white),
                        child: Row(children: [
                          Container(
                              height: 90.0,
                              width: 90.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10.0),
                                      topLeft: Radius.circular(10.0)),
                                  image: DecorationImage(
                                      image:
                                          NetworkImage(bannerData[index].image),
                                      fit: BoxFit.cover))),
                          SizedBox(width: 5.0),
                          new Expanded(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                setCommonText(bannerData[index].name,
                                    Colors.black, 14.0, FontWeight.w600, 2),
                                SizedBox(height: 5),
                                setCommonText(bannerData[index].address,
                                    Colors.grey[800], 12.0, FontWeight.w500, 2),
                              ]))
                        ]))))
          ])),
    );
  }
}
