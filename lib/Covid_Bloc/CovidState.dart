import 'package:equatable/equatable.dart';

class CovidState extends Equatable {
  final bool loading;
  final int totalGlobal;
  final int deathGlobal;
  final int recoverGlobal;
  final int totalVN;
  final int deathVN;
  final int recoverVN;
  final List<dynamic> listCountriesSearch;
  final String country;
  final int totalCountry;
  final int deathCountry;
  final int recoverCountry;

  // final String vietNam;

  CovidState({
    this.loading = true,
    this.totalGlobal,
    this.deathGlobal,
    this.recoverGlobal,
    this.totalVN,
    this.deathVN,
    this.recoverVN,
    this.listCountriesSearch,
    this.country = '...',
    this.totalCountry = 0,
    this.deathCountry = 0,
    this.recoverCountry = 0,
  });

  CovidState copyWith({
    bool loading,
    int totalGlobal,
    int deathGlobal,
    int recoverGlobal,
    int totalVN,
    int deathVN,
    int recoverVN,
    List<dynamic> listCountriesSearch,
    String country,
    int totalCountry,
    int deathCountry,
    int recoverCountry,
  }) =>
      CovidState(
          loading: loading ?? this.loading,
          totalGlobal: totalGlobal ?? this.totalGlobal,
          deathGlobal: deathGlobal,
          recoverGlobal: recoverGlobal,
          totalVN: totalVN,
          deathVN: deathVN,
          recoverVN: recoverVN,
          listCountriesSearch: listCountriesSearch,
          country: country ?? this.country,
          totalCountry: totalCountry ?? this.totalCountry,
          deathCountry: deathCountry ?? this.deathCountry,
          recoverCountry: recoverCountry) ??
      this.recoverCountry;

  @override
  // TODO: implement props
  List<Object> get props => [
        loading,
        totalGlobal,
        deathGlobal,
        recoverGlobal,
        totalVN,
        deathVN,
        recoverVN,
        listCountriesSearch,
        country,
        totalCountry,
        deathCountry,
        recoverCountry,
      ];

  @override
  bool operator ==(Object other) {
    if (props == null || props.isEmpty) {
      return false;
    }
    return super == other;
  }

  @override
  bool get stringify {
    return true;
  }

  @override
  int get hashCode {
    return super.hashCode;
  }
}
