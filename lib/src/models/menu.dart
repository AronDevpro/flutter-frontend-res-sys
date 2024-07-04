class Menu {
  final String id;
  final String itemName;
  final double price;

  Menu({
    required this.id,
    required this.itemName,
    required this.price,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      '_id': String id,
      'itemName': String itemName,
      'price': num price,
      } =>
          Menu(
            id: id,
            itemName: itemName,
            price: price.toDouble(),
          ),
      _ => throw const FormatException('Failed to load menu.'),
    };
  }
}
