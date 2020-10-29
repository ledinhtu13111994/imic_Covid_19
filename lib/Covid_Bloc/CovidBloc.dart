import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'CovidEvent.dart';
import 'CovidState.dart';
import 'dart:convert' as convert;
import 'package:translator/translator.dart';

class CovidBloc extends Bloc<CovidEvent, CovidState> {
  CovidBloc() : super(CovidState()) {}
  final GoogleTranslator translator = new GoogleTranslator();


  @override
  Stream<CovidState> mapEventToState(CovidEvent event) async* {
    final url = "https://api.covid19api.com/summary";
    var response = await get(url);
    var jsonResponse = convert.jsonDecode(response.body);
    List<dynamic> countries = jsonResponse['Countries'];
    List <String> countriesListTranslation = [];
    int totalVN;
    int deathVN;
    int recoverVN;
    var abc = translator.translate('China' , from: 'en', to: 'vi').toString();
    var bca = abc.toString();
    print('ban dich:  $abc');

    for (int i = 0; i < countries.length; i++) {
      var translation = await translator.translate(
          countries[i]['Country'].toString(), from: 'en', to: 'vi');
      String textTranslation = translation.toString();
      countriesListTranslation.add(textTranslation);}
    for (int i = 0; i < countries.length; i++) {
      if (countries[i]['CountryCode'] == 'VN') {
        totalVN = countries[i]['TotalConfirmed'];
        deathVN = countries[i]['TotalDeaths'];
        recoverVN = countries[i]['TotalRecovered'];
      }
    }
    switch (event.runtimeType) {
      case InittialEvent:
        yield state.copyWith(
          totalGlobal: jsonResponse['Global']["TotalConfirmed"],
          deathGlobal: jsonResponse['Global']['TotalDeaths'],
          recoverGlobal: jsonResponse['Global']['TotalRecovered'],
          totalVN: totalVN,
          deathVN: deathVN,
          recoverVN: recoverVN,
          loading: false,
        );
        break;
      case SearchCountryEvent:
        List<dynamic> listSearch = [];
        final _event = event as SearchCountryEvent;
        for (int i = 0; i < countriesListTranslation.length; i++) {
          if (countriesListTranslation[i].contains(_event.textSearch) ||
              _event.textSearch == countriesListTranslation[i]) {
            listSearch.add(countriesListTranslation[i]);
          }
        }
          yield state.copyWith(
              totalGlobal: jsonResponse['Global']["TotalConfirmed"],
              deathGlobal: jsonResponse['Global']['TotalDeaths'],
              recoverGlobal: jsonResponse['Global']['TotalRecovered'],
              totalVN: totalVN,
              deathVN: deathVN,
              recoverVN: recoverVN,
              loading: true,
              listCountriesSearch: listSearch,
          );
        break;
      case ChoseItemSearchEvent:
        final _event = event as ChoseItemSearchEvent;
        var translation = await translator.translate(_event.textChose, from: 'vi', to: 'en');
        String textTranslation = translation.toString();
        for(int i = 0; i <countries.length; i++) {
          if (translation == countries[i]['Country'])
            yield state.copyWith(
              totalGlobal: jsonResponse['Global']["TotalConfirmed"],
              deathGlobal: jsonResponse['Global']['TotalDeaths'],
              recoverGlobal: jsonResponse['Global']['TotalRecovered'],
              totalVN: totalVN,
              deathVN: deathVN,
              recoverVN: recoverVN,
              country: countries[i]['Country'],
              totalCountry: countries[i]["TotalConfirmed"],
              deathCountry: countries[i]['TotalDeaths'],
              recoverCountry: countries[i]['TotalRecovered'],
              loading: false,
            );
        }
          break;
      default:
        break;
    }
  }
}
