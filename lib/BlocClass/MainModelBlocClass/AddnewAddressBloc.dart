import 'package:product/BlocClass/CommonBlocClass/BaseBloc.dart';
import 'package:product/ModelClass/ModelAddNewAddress.dart';


//Add New Address Bloc
class AddnewAddressBloc extends BaseBloc<ResAddAddress>{
    Stream<ResAddAddress> get addNewAddress => fetcher.stream;
    addNewAddressForOrder(dynamic param)async{
        // ResAddAddress addNewAddress = await repository.addNewAddressForOrder(param);
        // fetcher.sink.add(addNewAddress);
    }
}


final addNewAddressBloc = AddnewAddressBloc();