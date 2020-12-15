import 'package:flutter/material.dart';
import 'package:notifier/main_notifier.dart';
import 'package:product/BlocClass/MainModelBlocClass/OrderListBloc.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/Helper/SharedManaged.dart';
import 'package:product/ModelClass/ModelOrderList.dart';
import 'package:product/generated/i18n.dart';
import 'Widgets/OrderListWidgets.dart';

void main() => runApp(new OrderScreen());

class OrderScreen extends StatefulWidget {
  updateOrder() => createState().updateOrderListData();
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
//1 received
//2 accept
//3 declined
//4 preparing
//5 delivered

  List<OrderStatus> orderStatusList = [
    OrderStatus('All', true, '0'),
    OrderStatus('Received', false, '1'),
    OrderStatus('Accepted', false, '2'),
    OrderStatus('Declined', false, '3'),
    OrderStatus('Preparing', false, '4'),
    OrderStatus('Delivered', false, '5'),
  ];

  List<Orders> result = [];
  List<Orders> orderListTmp = [];
  bool isFirst = true;

  @override
  void initState() {
    (SharedManager.shared.isLoggedIN == 'yes')
        ? orderListBloc.fetchOrderList(
            SharedManager.shared.userID, '0', APIS.orderList)
        : new Text('');
    super.initState();
  }

  //This is callback function
  updateOrderListData() => orderListBloc.fetchOrderList(
      SharedManager.shared.userID, '0', APIS.orderList);

  _setOrderList(String status) {
    this.result = [];
    for (var order in this.orderListTmp) {
      if (status == '0') {
        this.result = this.orderListTmp;
      } else {
        if (status == order.orderStatus) {
          this.result.add(order);
        }
      }
    }
    // setState(() {});
    print('Final Filter count:${this.result.length}');
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: AppColor.themeColor,
        centerTitle: true,
        title: setCommonText(
            S.current.history_order, AppColor.white, 20.0, FontWeight.w500, 1),
      ),
      body: (SharedManager.shared.isLoggedIN == 'yes')
          ? StreamBuilder(
              stream: orderListBloc.orderList,
              builder: (context, AsyncSnapshot<ResOrderList> snapshot) {
                if (snapshot.hasData) {
                  orderListTmp = snapshot.data.orderList;
                  if (isFirst) {
                    _setOrderList('0');
                    this.isFirst = false;
                  }

                  return new Container(
                      color: AppColor.white,
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 45,
                            padding: EdgeInsets.only(
                                left: 5, right: 5, top: 5, bottom: 3),
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: orderStatusList.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: EdgeInsets.only(
                                        left: 5, right: 5, top: 0, bottom: 0),
                                    child: InkWell(
                                      onTap: () {
                                        for (var status
                                            in this.orderStatusList) {
                                          status.isSelect = false;
                                        }
                                        _setOrderList(
                                            this.orderStatusList[index].value);
                                        setState(() {
                                          this.orderStatusList[index].isSelect =
                                              true;
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: (orderStatusList[index]
                                                        .isSelect)
                                                    ? AppColor.themeColor
                                                    : AppColor.black54),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Center(
                                          child: setCommonText(
                                              '   ${orderStatusList[index].status}   ',
                                              (orderStatusList[index].isSelect)
                                                  ? AppColor.themeColor
                                                  : AppColor.black87,
                                              13.0,
                                              (orderStatusList[index].isSelect)
                                                  ? FontWeight.bold
                                                  : FontWeight.w400,
                                              1),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          Divider(),
                          new Expanded(
                            child: (result.length > 0)
                                ? ListView.builder(
                                    itemCount: result.length,
                                    itemBuilder: (context, index) {
                                      return Notifier.of(context)
                                          .register<String>('action', (data) {
                                        return OrderListCard(result[index]);
                                      });
                                    },
                                  )
                                : dataFound(
                                    context,
                                    S.current.no_order_found,
                                    AssetImage(AppImages.cartDefaultImage),
                                    "0"),
                          )
                        ],
                      ));
                } else {
                  return Container(
                    color: AppColor.white,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            )
          : setLockedAccessWidgets(context, false),
    );
  }
}

class OrderStatus {
  String status;
  bool isSelect;
  String value;
  OrderStatus(this.status, this.isSelect, this.value);
}
