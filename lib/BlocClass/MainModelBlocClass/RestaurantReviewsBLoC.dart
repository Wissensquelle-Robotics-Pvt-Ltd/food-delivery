import 'package:product/BlocClass/CommonBlocClass/BaseBloc.dart';
import 'package:product/ModelClass/ModelAllReviewList.dart';

class RestaurantReviewsBLoC extends BaseBloc<ResAllReview> {
  Stream<ResAllReview> get restaurantReviews => fetcher.stream;
  fetchRestaurantReviews(String resId) async {
    ResAllReview resDetails = await repository.fetchRestaurantReviews(resId);
    fetcher.sink.add(resDetails);
  }
}

final restaurantReviewsBloc = RestaurantReviewsBLoC();
