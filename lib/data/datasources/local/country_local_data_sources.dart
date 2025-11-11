abstract class CountryLocalDataSource {
  Future<void> addFavourite(String code);
  Future<void> removeFavourite(String code);
  List<String> getFavouriteCodes();
}
