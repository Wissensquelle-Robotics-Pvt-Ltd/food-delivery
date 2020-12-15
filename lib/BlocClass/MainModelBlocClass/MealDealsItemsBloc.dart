import 'package:product/BlocClass/CommonBlocClass/BaseBloc.dart';
import 'package:product/ModelClass/ModelMealDeals.dart';

class MealDealsItemsBloc extends BaseBloc<ResMealDeals> {
  Stream<ResMealDeals> get mealDealsItems => fetcher.stream;
  fetchMealDealsItems(String url) async {
    ResMealDeals mealDeals = await repository.fetchMealDealsItems(url);
    fetcher.sink.add(mealDeals);
  }
}

final mealDealsItemsBloc = MealDealsItemsBloc();
