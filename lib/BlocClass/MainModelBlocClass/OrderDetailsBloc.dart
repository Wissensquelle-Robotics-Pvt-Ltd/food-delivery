
import 'package:product/BlocClass/CommonBlocClass/BaseBloc.dart';
import 'package:product/ModelClass/ModelOrderDetails.dart';


class OrderDetailsBloc extends BaseBloc<ResOrderDetails>{
    Stream<ResOrderDetails> get orderDetails => fetcher.stream;
    fetchOrderDetails(String orderId)async{
        ResOrderDetails orderDetails = await repository.fetchOrderDetails(orderId);
        fetcher.sink.add(orderDetails);
    }
}


final orderDetailsBloc = OrderDetailsBloc();