import 'package:product/BlocClass/CommonBlocClass/BaseBloc.dart';
import 'package:product/ModelClass/Dashboard.dart';


class DashboardBloc extends BaseBloc<Dashboard>{
    Stream<Dashboard> get dashboardData => fetcher.stream;
    fetchDashboardData(String url,dynamic param)async{
        Dashboard restaurantData = await repository.fetchDashboardData(url, param);
        fetcher.sink.add(restaurantData);
    }
}


final dashboardBloc = DashboardBloc();