class Facilities {
  String? water;
  double? waterPrice;
  String? gatorade;
  double? gatoradePrice;
  String? kit;

  Facilities({
    this.water,
    this.waterPrice,
    this.gatorade,
    this.gatoradePrice,
    this.kit,
  });

  Map<String, dynamic> toMap() {
    return {
      'water': water,
      'waterPrice': waterPrice,
      'gatorade': gatorade,
      'gatoradePrice': gatoradePrice,
      'kit': kit,
    };
  }
}
