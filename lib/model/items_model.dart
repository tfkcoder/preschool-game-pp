class Items {
  final String img;
  final String title;
  final String subTitle;

  ///
  Items({
    required this.img,
    required this.title,
    required this.subTitle,
  });
}

List<Items> listOfItems = [
  Items(
    img: "assets/reading.png",
    title: "HUJAMBO\nKaribu tujifunze wote mtoto mzuri",
    subTitle:
        "Jifunze namba, rangi,wanyama,vyakula\n na vingine vingi kwa urahisi zaidi",
  ),
  Items(
    img: "assets/reading2.png",
    title: "Jifunze kwa urahisi zaidi\nndani ya pre-schoolApp",
    subTitle:
        "Jifunze kwa kuona picha\n Kusikiliza sauti \n na kusoma maelezo",
  ),
  Items(
    img: "assets/reading3.png",
    title: "Fanya mazoezi na maswali\nmengi",
    subTitle: "Fanya maswali mengi kuhusu pre-schoolApp\nkwa pamoja",
  ),
];


class WanyamaNyumbani{
    final String img;
  final String title;
  final String audioUrl;

  WanyamaNyumbani({
    required this.img, required this.title, required this.audioUrl,
  });
}

List<WanyamaNyumbani> listOfIWanyama =[
  WanyamaNyumbani (audioUrl: "",title: "",img: "")
];