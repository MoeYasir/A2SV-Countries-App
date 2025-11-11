import 'package:a2sv_project/data/repositories/country_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'country_detail_state.dart';

class CountryDetailCubit extends Cubit<CountryDetailState> {
  final CountryRepository _countryRepository;

  CountryDetailCubit(this._countryRepository) : super(CountryDetailInitial());

  Future<void> fetchCountryDetails(String code) async {
    try {
      emit(CountryDetailLoading());
      final countryDetails = await _countryRepository.getCountryDetails(code);
      emit(CountryDetailLoaded(countryDetails));
    } catch (e) {
      emit(CountryDetailError('Failed to fetch country details.'));
    }
  }
}
