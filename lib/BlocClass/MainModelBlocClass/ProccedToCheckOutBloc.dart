import 'package:product/BlocClass/CommonBlocClass/BaseBloc.dart';
import 'package:product/ModelClass/ModelCheckOut.dart';

class ProccedToCheckOutBloc extends BaseBloc<ResAddOrder> {
  Stream<ResAddOrder> get checkOut => fetcher.stream;
  proccedToCheckOut(String strUrl, dynamic param) async {
    ResAddOrder resDetails = await repository.proccedToCheckOut(strUrl, param);
    fetcher.sink.add(resDetails);
  }
}

final checkOutBloc = ProccedToCheckOutBloc();
