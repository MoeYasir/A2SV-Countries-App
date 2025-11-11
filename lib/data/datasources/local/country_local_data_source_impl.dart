import 'package:a2sv_project/data/datasources/local/country_local_data_sources.dart';
import 'package:hive/hive.dart';

class CountryLocalDataSourceImpl implements CountryLocalDataSource {
  final Box<String> _favouritesBox;

  CountryLocalDataSourceImpl(this._favouritesBox);

  @override
  Future<void> addFavourite(String code) async {
    await _favouritesBox.put(code, code);
  }

  @override
  List<String> getFavouriteCodes() {
    return _favouritesBox.keys.cast<String>().toList();
  }

  @override
  Future<void> removeFavourite(String code) async {
    await _favouritesBox.delete(code);
  }
}
