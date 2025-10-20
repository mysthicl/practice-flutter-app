class Product {
  final String name;
  final double price;

  Product({required this.name, required this.price});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      price: (json['price'] as num).toDouble(),
    );
  }
}

class ProductCategory{
  final String category;
  final List<Product> items;

  ProductCategory({required this.category, required this.items});

  factory ProductCategory.fromJson(Map<String, dynamic> json){
    var list = json['items'] as List;
    List<Product> itemsList = list.map((i) => Product.fromJson(i)).toList();

    return ProductCategory(
      category: json['category'], 
      items: itemsList,);
  }
}