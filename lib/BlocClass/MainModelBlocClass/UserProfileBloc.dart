import 'package:product/BlocClass/CommonBlocClass/BaseBloc.dart';
import 'package:product/ModelClass/ModelProfileData.dart';

class UserProfileBloc extends BaseBloc<ResProfileData> {
  Stream<ResProfileData> get profileData => fetcher.stream;
  fetchProfileData(String userId) async {
    ResProfileData restaurantData = await repository.fetchProfileData(userId);
    fetcher.sink.add(restaurantData);
  }
}

final userProfileBloc = UserProfileBloc();
