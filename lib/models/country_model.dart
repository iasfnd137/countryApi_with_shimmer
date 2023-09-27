//cliprect hum image k border k liye use karthy thy
//clipovel pory image ko gol karta hy
//cirxular avatar ic ko circle krta hy
class CountryModel{

  String name;
  String? capital;
  String subregion;
  String region;
  String flag;
  int population;
  List<dynamic>? borders;

  CountryModel(
  {   required this.name,
      this.capital,
      required this.subregion,
      required this.region,
      required this.flag,
      required this.population,
      this.borders});

  static CountryModel fromJSON(Map<String,dynamic>map){

    return CountryModel(
        name:map ['name'],
        capital:map ['capital'],
        subregion:map ['subregion'],
        region:map ['region'],
        flag:map ['flag'],
        population:map ['population'],
        borders:map ['borders'],

    );
  }
}
