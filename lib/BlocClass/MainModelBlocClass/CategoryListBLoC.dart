//

import 'package:product/BlocClass/CommonBlocClass/BaseBloc.dart';
import 'package:product/ModelClass/ModelCategoryList.dart';

class CategoryListBLoC extends BaseBloc<ResCategoryList> {
  Stream<ResCategoryList> get categoryList => fetcher.stream;
  fetchAllCategoryList() async {
    ResCategoryList restaurantList = await repository.fetchCategoryList();
    fetcher.sink.add(restaurantList);
  }
}

final categoryListBloc = CategoryListBLoC();
