import 'package:product/BlocClass/CommonBlocClass/BaseBloc.dart';
import 'package:product/ModelClass/ModelAllRestaurantList.dart';

class AllRestaurantListBloc extends BaseBloc<ResAllRestaurantList> {
  Stream<ResAllRestaurantList> get restaurantList => fetcher.stream;
  fetchAllRestaurant(String url) async {
    ResAllRestaurantList restaurantList =
        await repository.fetchAllRestaurantList(url);
    fetcher.sink.add(restaurantList);
  }
}

final allRestaurantListBloc = AllRestaurantListBloc();
