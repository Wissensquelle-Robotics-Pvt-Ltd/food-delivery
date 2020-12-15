import 'package:flutter/material.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/Helper/SharedManaged.dart';
import 'package:product/ModelClass/ModelRestaurantDetails.dart';
import 'package:product/Screens/Cart/Cart.dart';
import 'package:product/generated/i18n.dart';

void main() => runApp(new RestaurantItemList());

class RestaurantItemList extends StatefulWidget {
  final title;
  final List<Subcategories> itemList;

  RestaurantItemList({Key key, this.title, this.itemList}) : super(key: key);
  @override
  _RestaurantItemListState createState() => _RestaurantItemListState();
}

class _RestaurantItemListState extends State<RestaurantItemList> {
  bool isGrid = false;
  var itemCount = 0;
  var totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    this.itemCount = this.itemCount + SharedManager.shared.cartItems.length;

    for (var item in SharedManager.shared.cartItems) {
      this.totalPrice = this.totalPrice +
          (double.parse(item.price) - double.parse(item.discount));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          elevation: 0.0,
          backgroundColor: AppColor.themeColor,
          title: setCommonText(
              this.widget.title, AppColor.white, 20.0, FontWeight.w600, 1),
          leading: new IconButton(
              icon: Icon(Icons.arrow_back_ios, color: AppColor.white),
              onPressed: () {
                Navigator.of(context).pop(true);
              }),
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
        body: new Container(
          child: new Column(
            children: <Widget>[
              Expanded(
                  child: this.isGrid
                      ? _setSubCategoryGrid(this.widget.itemList)
                      : _setSubCategoryList(this.widget.itemList)),
              (this.itemCount > 0)
                  ? new Container(
                      height: 70,
                      padding: new EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      child: new Container(
                        color: AppColor.grey[100],
                        height: 60,
                        child: new Material(
                            color: AppColor.themeColor,
                            borderRadius: new BorderRadius.circular(35),
                            child: new Container(
                              padding: new EdgeInsets.only(left: 20, right: 15),
                              child: new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Text(
                                        "${this.itemCount} ${S.current.items}",
                                        style: new TextStyle(
                                            color: AppColor.white,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      new Text(
                                        "${S.current.totals} ${Currency.curr}${this.totalPrice}",
                                        style: new TextStyle(
                                            color: AppColor.white,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                  new Row(
                                    children: <Widget>[
                                      new GestureDetector(
                                          onTap: () {
                                            SharedManager.shared.isFromTab =
                                                false;
                                            for (var item
                                                in this.widget.itemList) {
                                              if (item.isAdded) {
                                                SharedManager.shared.cartItems
                                                    .add(item);
                                              }
                                            }
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CartApp()));
                                          },
                                          child: setCommonText(
                                              S.current.view_cart,
                                              AppColor.white,
                                              18.0,
                                              FontWeight.w500,
                                              1)),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      new Icon(Icons.arrow_forward,
                                          color: AppColor.white)
                                    ],
                                  )
                                ],
                              ),
                            )),
                      ),
                    )
                  : new Container()
            ],
          ),
        ));
  }

  _setSubCategoryGrid(List data) {
    return new Container(
      // color:AppColor.red,
      child: new GridView.count(
        childAspectRatio: 6 / 6.5,
        crossAxisCount: 2,
        children: List.generate(this.widget.itemList.length, (row) {
          return new GestureDetector(
            onTap: () async {},
            child: new Container(
              // color: AppColor.white,
              padding: new EdgeInsets.all(4),
              child: Stack(
                children: <Widget>[
                  new Material(
                    elevation: 3.0,
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(6),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Expanded(
                          flex: 3,
                          child: new Container(
                            // color: AppColor.green,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                        this.widget.itemList[row].image)),
                                borderRadius: new BorderRadius.only(
                                    topLeft: Radius.circular(6),
                                    topRight: Radius.circular(6))),
                          ),
                        ),
                        new Expanded(
                          flex: 2,
                          child: new Container(
                            // color: AppColor.white,
                            padding:
                                new EdgeInsets.only(left: 5, top: 3, right: 5),
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                setCommonText(
                                    this.widget.itemList[row].name,
                                    AppColor.grey[800],
                                    14.0,
                                    FontWeight.w700,
                                    1),
                                new Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(children: <Widget>[
                                      setCommonText('4.1', AppColor.orange,
                                          12.0, FontWeight.w500, 1),
                                      Icon(Icons.star,
                                          color: AppColor.orange, size: 14)
                                    ]),
                                    Row(
                                      children: <Widget>[
                                        new Stack(
                                          alignment: Alignment.center,
                                          children: <Widget>[
                                            setCommonText(
                                                '${Currency.curr}${this.widget.itemList[row].price}',
                                                AppColor.grey[600],
                                                10.0,
                                                FontWeight.w700,
                                                1),
                                            new Container(
                                              height: 2,
                                              width: 40,
                                              color: AppColor.grey[700],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        setCommonText(
                                            '${Currency.curr}${((double.parse(this.widget.itemList[row].price) - (double.parse(this.widget.itemList[row].discount))))}',
                                            AppColor.grey[800],
                                            10.0,
                                            FontWeight.w700,
                                            1),
                                      ],
                                    ),
                                  ],
                                ),
                                new Row(
                                  children: <Widget>[
                                    new Expanded(
                                      flex: 3,
                                      child: new Container(
                                        height: 30,
                                        // color:AppColor.red,
                                        child: new Wrap(
                                          children: <Widget>[
                                            setCommonText(
                                                this
                                                    .widget
                                                    .itemList[row]
                                                    .description,
                                                AppColor.grey,
                                                12.0,
                                                FontWeight.w500,
                                                2),
                                          ],
                                        ),
                                      ),
                                    ),
                                    new Expanded(
                                      flex: 1,
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            if (this
                                                .widget
                                                .itemList[row]
                                                .isAdded) {
                                              this
                                                  .widget
                                                  .itemList[row]
                                                  .isAdded = false;
                                            } else {
                                              this
                                                  .widget
                                                  .itemList[row]
                                                  .isAdded = true;
                                            }
                                            this.itemCount = _setItemCount();
                                          });
                                        },
                                        child: new Container(
                                          height: 25,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: AppColor.grey),
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      10)),
                                          child: new Center(
                                              child: (this
                                                      .widget
                                                      .itemList[row]
                                                      .isAdded)
                                                  ? Icon(Icons.check,
                                                      color: AppColor.red,
                                                      size: 20)
                                                  : setCommonText(
                                                      S.current.add_plus,
                                                      AppColor.themeColor,
                                                      11.0,
                                                      FontWeight.w500,
                                                      2)),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  (data[row].isAvailable == '0')
                      ? setItemOutOfStockWidget(
                          context, '${S.current.outOfStock}')
                      : Text(''),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  _setSubCategoryList(List data) {
    return new Container(
      color: AppColor.grey[100],
      child: new ListView.builder(
        itemCount: this.widget.itemList.length,
        itemBuilder: (context, row) {
          return new Container(
            padding: new EdgeInsets.all(5),
            height: 120,
            child: new Material(
              color: AppColor.white,
              elevation: 3.0,
              borderRadius: new BorderRadius.circular(5),
              child: new Row(
                children: <Widget>[
                  new Expanded(
                      flex: 1,
                      child: new Stack(
                        children: <Widget>[
                          new Container(
                            // color: AppColor.yellow,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      this.widget.itemList[row].image),
                                  fit: BoxFit.cover),
                              borderRadius: new BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  bottomLeft: Radius.circular(5)),
                            ),
                          ),
                          new Align(
                            alignment: Alignment.bottomRight,
                            child: new Container(
                              padding: new EdgeInsets.all(5),
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        (this.widget.itemList[row].type == "1")
                                            ? AssetImage(AppImages.vegItem)
                                            : AssetImage(AppImages.nonVegItem),
                                    fit: BoxFit.cover),
                                borderRadius: new BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    bottomLeft: Radius.circular(5)),
                              ),
                            ),
                          ),
                          (data[row].isAvailable == '0')
                              ? setItemOutOfStockWidget(
                                  context, '${S.current.outOfStock}')
                              : Text(''),
                        ],
                      )),
                  SizedBox(
                    width: 5,
                  ),
                  new Expanded(
                    flex: 2,
                    child: new Container(
                      padding: new EdgeInsets.only(top: 10, right: 10),
                      color: AppColor.white,
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Row(
                            children: <Widget>[
                              new Expanded(
                                flex: 3,
                                child: new Container(
                                  color: AppColor.white,
                                  height: 40,
                                  child: new Align(
                                    alignment: Alignment.topLeft,
                                    child: setCommonText(
                                        this.widget.itemList[row].name,
                                        AppColor.black,
                                        15.0,
                                        FontWeight.w600,
                                        2),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              new Expanded(
                                flex: 1,
                                child: new Container(
                                  height: 30,
                                  child: new Material(
                                    color: AppColor.grey[600],
                                    borderRadius: new BorderRadius.circular(10),
                                    child: new Container(
                                      padding: new EdgeInsets.all(1),
                                      child: InkWell(
                                        onTap: () {
                                          if (data[row].isAvailable == '1') {
                                            setState(() {
                                              if (this
                                                  .widget
                                                  .itemList[row]
                                                  .isAdded) {
                                                this
                                                    .widget
                                                    .itemList[row]
                                                    .isAdded = false;
                                              } else {
                                                this
                                                    .widget
                                                    .itemList[row]
                                                    .isAdded = true;
                                              }
                                              this.itemCount = _setItemCount();
                                            });
                                          } else {
                                            commonItemOutofStockAlert(context);
                                          }
                                        },
                                        child: new Material(
                                          color: AppColor.white,
                                          borderRadius:
                                              new BorderRadius.circular(10),
                                          child: new Center(
                                            child: (this
                                                    .widget
                                                    .itemList[row]
                                                    .isAdded)
                                                ? setCommonText(
                                                    S.current.added,
                                                    AppColor.red,
                                                    13.0,
                                                    FontWeight.w700,
                                                    1)
                                                : setCommonText(
                                                    S.current.add_plus,
                                                    AppColor.themeColor,
                                                    13.0,
                                                    FontWeight.w700,
                                                    1),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          setCommonText(this.widget.itemList[row].description,
                              AppColor.grey, 12.0, FontWeight.w500, 2),
                          SizedBox(
                            height: 3,
                          ),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Row(
                                children: <Widget>[
                                  setCommonText('4.0', AppColor.orange, 12.0,
                                      FontWeight.w600, 1),
                                  new Icon(
                                    Icons.star,
                                    color: AppColor.orange,
                                    size: 14,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  setCommonText(S.current.votes, AppColor.grey,
                                      12.0, FontWeight.w600, 1),
                                ],
                              ),
                              new Row(
                                children: <Widget>[
                                  new Stack(
                                    alignment: Alignment.center,
                                    children: <Widget>[
                                      setCommonText(
                                          '${Currency.curr}${this.widget.itemList[row].price}',
                                          AppColor.grey,
                                          12.0,
                                          FontWeight.w600,
                                          1),
                                      new Container(
                                        height: 2,
                                        width: 40,
                                        color: AppColor.grey[700],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  setCommonText(
                                      '${Currency.curr}${((double.parse(this.widget.itemList[row].price)) - (double.parse(this.widget.itemList[row].discount)))}',
                                      AppColor.black,
                                      12.0,
                                      FontWeight.w600,
                                      1),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  int _setItemCount() {
    var count = 0;
    this.totalPrice = 0.0;
    for (int i = 0; i < this.widget.itemList.length; i++) {
      if (this.widget.itemList[i].isAdded) {
        count = count + 1;
        this.totalPrice = this.totalPrice +
            (double.parse(this.widget.itemList[i].price) -
                double.parse(this.widget.itemList[i].discount));
      }
    }
    for (var item in SharedManager.shared.cartItems) {
      count = count + 1;
      this.totalPrice = this.totalPrice +
          (double.parse(item.price) - double.parse(item.discount));
    }
    return count;
  }
}
