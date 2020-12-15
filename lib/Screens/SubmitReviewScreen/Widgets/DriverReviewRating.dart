import 'package:flutter/material.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/Helper/RequestManager.dart';
import 'package:product/Helper/SharedManaged.dart';
import 'package:product/generated/i18n.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class DriverReviewRating extends StatefulWidget {
  final String orderID;
  final String driverId;
  DriverReviewRating(this.orderID, this.driverId);
  @override
  _DriverReviewRatingState createState() => _DriverReviewRatingState();
}

class _DriverReviewRatingState extends State<DriverReviewRating> {
  TextEditingController reviewController = TextEditingController();
  double review = 0.0;
  bool ratingStatus = false;

  Future<bool> _submitRestaurantReview(dynamic param) async {
    Requestmanager manager = Requestmanager();
    await manager
        .requestForAddRestaurantReview(param, APIS.addDriverReview)
        .then((value) {
      ratingStatus = value;
    });
    return ratingStatus;
  }

  bool _checkValidations() {
    if (this.review == 0.0) {
      SharedManager.shared
          .showAlertDialog('${S.current.pleaseAddReviewFirst}', context);
      return false;
    } else if (this.reviewController.text == "") {
      SharedManager.shared
          .showAlertDialog('${S.current.pleaseWriteReviewFirst}', context);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: new EdgeInsets.all(15),
      child: Material(
        elevation: 2.0,
        borderRadius: BorderRadius.circular(5),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              setCommonText('${S.current.howWouldYouRateDelivery}',
                  AppColor.black87, 18.0, FontWeight.w500, 1),
              SizedBox(
                height: 5,
              ),
              SmoothStarRating(
                  allowHalfRating: true,
                  onRated: (v) {
                    print(v);
                    this.review = v;
                  },
                  starCount: 5,
                  rating: 0.0,
                  size: 40.0,
                  isReadOnly: false,
                  filledIconData: Icons.star,
                  halfFilledIconData: Icons.star_half,
                  color: Colors.orange,
                  borderColor: Colors.orange,
                  spacing: 0.0),
              SizedBox(
                height: 8,
              ),
              Expanded(
                  child: Container(
                padding: new EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    color: AppColor.grey[100],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColor.grey[400])),
                child: TextFormField(
                  controller: reviewController,
                  keyboardType: TextInputType.text,
                  maxLines: 8, //Number_of_lines(int),)
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '${S.current.tellUsAboutDriver}'),
                ),
              )),
              SizedBox(
                height: 12,
              ),
              InkWell(
                onTap: () async {
                  final statusValidations = _checkValidations();
                  if (statusValidations == false) {
                    return;
                  }
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Center(
                          child: CircularProgressIndicator(
                            backgroundColor: AppColor.themeColor,
                          ),
                        );
                      });

                  var param = {
                    "customer_id": SharedManager.shared.userID,
                    "order_id": this.widget.orderID,
                    "driver_id": this.widget.driverId,
                    "review": this.review,
                    "message": this.reviewController.text
                  };

                  await _submitRestaurantReview(param).then((value) {
                    if (value) {
                      Navigator.pop(context);
                      SharedManager.shared.showAlertDialog(
                          '${S.current.reviewAddedSuccessfully}', context);
                      setState(() {
                        this.reviewController.text = "";
                        this.review = 0.0;
                      });
                    } else {
                      Navigator.pop(context);
                      SharedManager.shared.showAlertDialog(
                          '${S.current.reviewAlreadyExist}', context);
                      setState(() {
                        this.reviewController.text = "";
                        this.review = 0.0;
                      });
                    }
                  });
                },
                child: Container(
                  height: 40,
                  width: 140,
                  decoration: BoxDecoration(
                      color: AppColor.deepOrange,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: setCommonText('${S.current.submitReview}',
                        AppColor.white, 16.0, FontWeight.w500, 1),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
