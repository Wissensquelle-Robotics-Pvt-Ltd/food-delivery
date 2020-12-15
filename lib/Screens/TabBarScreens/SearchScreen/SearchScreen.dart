import 'package:flutter/material.dart';
import 'package:product/BlocClass/MainModelBlocClass/SearchResultDataBloc.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/ModelClass/ModelSearchResult.dart';
import 'package:product/generated/i18n.dart';
import 'Widgets/PopularRestaurantsWidget.dart';
import 'Widgets/RecentSearchWidget.dart';

void main() => runApp(new SearchScreen());

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isSearch = false;
  var searchKeyWord = "";

  _setSearchTopBarView() {
    return Container(
        padding: new EdgeInsets.all(15),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              width: MediaQuery.of(context).size.width,
              child: new Material(
                color: AppColor.grey[100],
                elevation: 3.0,
                borderRadius: new BorderRadius.circular(25),
                child: new Padding(
                  padding: new EdgeInsets.only(left: 10, right: 10),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Icon(
                        Icons.search,
                        color: AppColor.grey,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      new Expanded(
                        child: new TextFormField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: new TextStyle(
                                  color: AppColor.grey, fontSize: 17),
                              hintText: S.current.search),
                          onSaved: (text) {
                            print("Text Text:$text");
                          },
                          onFieldSubmitted: (value) {
                            print("Text Value:$value");
                            if (value != "") {
                              setState(() {
                                this.searchKeyWord = value;
                                this.isSearch = true;
                              });
                            }
                          },
                          autocorrect: false,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }

  _searchEmptyContainer() {
    return new Container(
      color: AppColor.white,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _setSearchTopBarView(),
          new Expanded(
              child: new Container(
            child: new Center(
              child: new Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    image: DecorationImage(
                        image: AssetImage('Assets/images/dataNotFound.png'),
                        fit: BoxFit.fill)),
              ),
            ),
          ))
          // _setLanguageOptions()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    this.isSearch
        ? searchResultBloc.fetchSearchResults(this.searchKeyWord)
        : new Text('');
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: new AppBar(
          centerTitle: true,
          backgroundColor: AppColor.themeColor,
          elevation: 0.0,
          title: setCommonText(
              S.current.searchItem, AppColor.white, 20.0, FontWeight.w500, 1),
        ),
        body: this.isSearch
            ? new StreamBuilder(
                stream: searchResultBloc.searchResult,
                builder: (context, AsyncSnapshot<ResSearchResult> snapshot) {
                  if (snapshot.hasData) {
                    this.isSearch = false;
                    final result = snapshot.data.result;
                    return ((result.restaurents.length == 0) &&
                            (result.mealDeal.length == 0))
                        ? _searchEmptyContainer()
                        : new Container(
                            color: AppColor.white,
                            child: new ListView(
                              children: <Widget>[
                                _setSearchTopBarView(),
                                PopularRestaurantWidget(result.restaurents),
                                RecentSearchWidget(result.mealDeal)
                                // _setLanguageOptions()
                              ],
                            ),
                          );
                  } else {
                    return new Center(child: new CircularProgressIndicator());
                  }
                })
            : _searchEmptyContainer());
  }
}
