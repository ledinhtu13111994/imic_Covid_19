import 'package:equatable/equatable.dart';

abstract class CovidEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class InittialEvent extends CovidEvent{}

class SearchCountryEvent extends CovidEvent {
  final String textSearch;

  SearchCountryEvent({this.textSearch});
}
class ChoseItemSearchEvent extends CovidEvent{
  final String textChose;

  ChoseItemSearchEvent({this.textChose});
}
