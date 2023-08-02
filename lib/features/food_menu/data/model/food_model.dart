class FoodModel {
  final String id;
  final String name;
  final double price;
  final String description;
  final String imageUrl;

  FoodModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
  });

  FoodModel copyWith({
    String? id,
    String? name,
    double? price,
    String? description,
    String? imageUrl,
  }) {
    return FoodModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  String toString() {
    return 'Id:$id, Name: $name, price: $price, description: $description,imageUrl:$imageUrl';
  }

  factory FoodModel.fromJson(String id, Map<String, dynamic> data) {
    return FoodModel(
      id: id,
      name: data['name'],
      price: data['price'].toDouble(),
      description: data['description'],
      imageUrl: data['imageUrl'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'imageUrl': imageUrl,
    };
  }
}
