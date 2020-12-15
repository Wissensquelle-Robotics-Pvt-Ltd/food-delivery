
import 'package:product/BlocClass/CommonBlocClass/BaseBloc.dart';
import 'package:product/ModelClass/ModelAddressList.dart';


class AddressListBloc extends BaseBloc<ResAddressList>{
    Stream<ResAddressList> get addressList => fetcher.stream;
    fetchAddressList(String url,String userID)async{
        ResAddressList addressList = await repository.fetchAddressList(url, userID);
        fetcher.sink.add(addressList);
    }
}


final addressListBloc = AddressListBloc();