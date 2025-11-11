import 'package:a2sv_project/data/datasources/local/country_local_data_sources.dart';
import 'package:hive/hive.dart';

class CountryLocalDataSourceImpl implements CountryLocalDataSource {
  final Box<String> _favoritesBox;

  CountryLocalDataSourceImpl(this._favoritesBox);

  @override
  Future<void> addFavourite(String code) async {
    await _favoritesBox.put(code, code);
  }

  @override
  List<String> getFavouriteCodes() {
    return _favoritesBox.keys.cast<String>().toList();
  }

  @override
  Future<void> removeFavourite(String code) async {
    await _favoritesBox.delete(code);
  }
}
