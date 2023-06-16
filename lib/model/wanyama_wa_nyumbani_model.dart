class Items {
  final String img;
  final String title;
  final String subTitle;
  final String audioUrl;

  ///
  Items({
    required this.img,
    required this.title,
    required this.subTitle,
    required this.audioUrl,
  });
}

List<Items> listOfItems = [
  Items(
    img: "assets/reading.png",
    title: "HUJAMBO\nKaribu tujifunze wote mtoto mzuri",
    subTitle: "Jifunze namba, rangi,wanyama,vyakula\n na vingine vingi kwa urahisi zaidi",
        audioUrl: ""
  ),
];
