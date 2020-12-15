import 'package:flutter/material.dart';
import 'package:product/BlocClass/MainModelBlocClass/MealDealsItemsBloc.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/Helper/SharedManaged.dart';
import 'package:product/ModelClass/ModelMealDeals.dart';
import 'package:product/Screens/AllRestaurantList/AllRestaurantList.dart';
import 'package:product/Screens/AllRestaurantList/Widgets/MealDealListviewWidget.dart';
import 'package:product/generated/i18n.dart';

class SubcategoryListScreen extends StatefulWidget {
  final String categoryID;
  final String categoryName;

  SubcategoryListScreen({this.categoryID, this.categoryName});

  @override
  _SubcategoryListScreenState createState() => _SubcategoryListScreenState();
}

class _SubcategoryListScreenState extends State<SubcategoryListScreen> {
  bool isGrid = false;

  @override
  Widget build(BuildContext context) {
    mealDealsItemsBloc
        .fetchMealDealsItems('${APIS.mealDeals}/${this.widget.categoryID}');
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: AppColor.themeColor,
        title: setCommonText(
            widget.categoryName, AppColor.white, 20.0, FontWeight.w500, 1),
        actions: <Widget>[
          SizedBox(width: 10),
          new IconButton(
              icon: this.isGrid
                  ? Icon(Icons.grid_on, color: AppColor.white)
                  : Icon(Icons.list, color: AppColor.white),
              onPressed: () {
                setState(() {
                  if (this.isGrid) {
                    this.isGrid = false;
                  } else {
                    this.isGrid = true;
                  }
                });
              }),
        ],
      ),
      body: StreamBuilder(
          stream: mealDealsItemsBloc.mealDealsItems,
          builder: (context, AsyncSnapshot<ResMealDeals> snapshot) {
            if (snapshot.hasData) {
              final result = snapshot.data.result;
              return (result.length > 0)
                  ? Column(
                      children: [
                        Expanded(
                          child: new Container(
                              child: this.isGrid
                                  ? GridViewMealWidget(result)
                                  : ListviewMealWidget(result)
                              // child: _setGridViewItems(context,''),
                              ),
                        ),
                        SizedBox(
                          height: 50,
                        )
                      ],
                    )
                  : new Center(
                      child: Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Text(
                          '${S.current.categoryNotAvailable}',
                          style: TextStyle(
                              color: AppColor.black87,
                              fontFamily: SharedManager.shared.fontFamilyName,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
            } else {
              return new Center(
                child: new CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
