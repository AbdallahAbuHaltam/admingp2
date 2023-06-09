class Facilities {
  String? water;
  String? waterPrice;
  String? gatorade;
  String? gatoradePrice;
  String? kit;

  Facilities({
    this.water,
    this.waterPrice,
    this.gatorade,
    this.gatoradePrice,
    this.kit,
  });

  Facilities.formJson(Map<String, dynamic>? json) {
    water = json?['water'];
    waterPrice = json?['waterPrice'];
    gatorade = json?['gatorade'];
    gatoradePrice = json?['gatoradePrice'];
    kit = json?['kit'];
  }

  Map<String, dynamic> toMap() {
    return {'water':water,
      'waterPrice':waterPrice,
      'gatorade':gatorade,
      'gatoradePrice':gatoradePrice,
      'kit':kit,};
  }
}
