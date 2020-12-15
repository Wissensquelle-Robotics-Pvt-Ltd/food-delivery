import 'package:product/BlocClass/CommonBlocClass/BaseBloc.dart';
import 'package:product/ModelClass/ModelOrderStatus.dart';

class OrderStatusBloc extends BaseBloc<ResOrderStatus> {
  Stream<ResOrderStatus> get orderStatus => fetcher.stream;
  fetchOrderStatus(String orderId) async {
    ResOrderStatus resDetails =
        await repository.fetchCurrentOrderStatus(orderId);
    fetcher.sink.add(resDetails);
  }
}

final orderStatusBloc = OrderStatusBloc();
