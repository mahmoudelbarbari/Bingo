class CategoriyEntity {
  final String? id;
  final String image;
  final String name;

  CategoriyEntity({this.id, required this.name, required this.image});
}

final List<CategoriyEntity> categoryList = [
  CategoriyEntity(id: '1', image: 'assets/images/jewelry.png', name: 'Jewelry'),
  CategoriyEntity(id: '2', image: 'assets/images/jewelry.png', name: 'Pottery'),
  CategoriyEntity(
    id: '3',
    image: 'assets/images/jewelry.png',
    name: 'Woodwork',
  ),
  CategoriyEntity(
    id: '4',
    image: 'assets/images/jewelry.png',
    name: 'Knitting',
  ),
  CategoriyEntity(
    id: '5',
    image: 'assets/images/jewelry.png',
    name: 'Painting',
  ),
  CategoriyEntity(id: '6', image: 'assets/images/jewelry.png', name: 'Leather'),
  CategoriyEntity(
    id: '7',
    image: 'assets/images/jewelry.png',
    name: 'Embroidery',
  ),
  CategoriyEntity(id: '8', image: 'assets/images/jewelry.png', name: 'Candles'),
  CategoriyEntity(id: '9', image: 'assets/images/jewelry.png', name: 'Soap'),
  CategoriyEntity(
    id: '10',
    image: 'assets/images/jewelry.png',
    name: 'Paper Crafts',
  ),
];
