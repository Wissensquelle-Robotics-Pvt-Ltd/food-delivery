
import 'package:product/BlocClass/CommonBlocClass/BaseMode.dart';
import 'package:product/BlocClass/CommonBlocClass/Repository.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseBloc<T extends BaseModel> {
  final repository = Repository();
  final fetcher = PublishSubject<T>();

  dispose() {
    fetcher.close();
  }
}