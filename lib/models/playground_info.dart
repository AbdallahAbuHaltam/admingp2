class PlaygroundInfo {
  final String name, image;
  final double? distance, rating, price;
  final PlaygroundType? type;

  PlaygroundInfo(
      {required this.name,
      required this.image,
      this.distance ,
      this.rating,
      this.price,
      this.type,
      }
  );
}

enum PlaygroundType {
  football,
  basketballcourt,
  swimmingpool,
  running,
  tennis,
  padel
}