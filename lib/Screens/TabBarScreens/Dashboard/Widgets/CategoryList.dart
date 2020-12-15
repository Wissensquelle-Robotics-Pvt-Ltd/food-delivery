import 'package:flutter/material.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/ModelClass/Dashboard.dart';
import 'package:product/Screens/CategoryListScreen/CategoryListScreen.dart';
import 'package:product/Screens/SubcategoryListScreen/SubcategoryListScreen.dart';
import 'package:product/generated/i18n.dart';
import 'package:progressive_image/progressive_image.dart';
import '../../../../Helper/Constant.dart';

class CategoryList extends StatelessWidget {
  final List<Categories> categoryList;
  CategoryList(this.categoryList);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 115,
      width: MediaQuery.of(context).size.width,
      color: AppColor.white,
      padding: new EdgeInsets.only(left: 2, right: 8, bottom: 0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                setCommonText('Cuisines around you', AppColor.black, 15.0,
                    FontWeight.w500, 1),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CategoryListScreen()));
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
          SizedBox(
            height: 8,
          ),
          Expanded(
              child: Container(
            color: AppColor.white,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoryList.length,
                itemBuilder: (builder, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SubcategoryListScreen(
                                categoryID: categoryList[index].categoryId,
                                categoryName: categoryList[index].categoryName,
                              )));
                    },
                    child: Container(
                      width: 90,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 60,
                            width: 60,
                            // color: AppColor.amber,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
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
                              //         '${categoryList[index].image}'))
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: ProgressiveImage(
                                placeholder: AssetImage('Assets/loading.gif'),
                                // size: 1.87KB
                                thumbnail: AssetImage('Assets/loading.gif'),
                                // size: 1.29MB
                                image: NetworkImage(categoryList[index].image),
                                height: 60,
                                width: 60,
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          setCommonText('${categoryList[index].categoryName}',
                              AppColor.black, 12.0, FontWeight.w400, 1)
                        ],
                      ),
                    ),
                  );
                }),
          ))
        ],
      ),
    );
  }
}
