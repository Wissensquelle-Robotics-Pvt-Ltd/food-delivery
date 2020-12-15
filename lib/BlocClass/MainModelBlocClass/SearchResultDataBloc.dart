import 'package:product/BlocClass/CommonBlocClass/BaseBloc.dart';
import 'package:product/ModelClass/ModelSearchResult.dart';


class SearchResultDataBloc extends BaseBloc<ResSearchResult>{
    Stream<ResSearchResult> get searchResult => fetcher.stream;
    fetchSearchResults(String keyWord)async{
        ResSearchResult searchResult = await repository.fetchSearchResultData(keyWord);
        fetcher.sink.add(searchResult);
    }
}


final searchResultBloc = SearchResultDataBloc();