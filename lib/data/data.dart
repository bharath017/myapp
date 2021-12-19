enum AnimalType { land, air }

class Animal {
  final String imageUrl;
  final AnimalType type;

  Animal({
    required this.imageUrl,
    required this.type,
  });
}

final allAnimals = [
  Animal(
    type: AnimalType.land,
    imageUrl: 'assets/animal1.png',
  ),
  Animal(
    type: AnimalType.air,
    imageUrl: 'assets/bird1.png',
  ),
  Animal(
    type: AnimalType.air,
    imageUrl: 'assets/bird2.png',
  ),
  Animal(
    type: AnimalType.land,
    imageUrl: 'assets/animal2.png',
  ),
  Animal(
    type: AnimalType.air,
    imageUrl: 'assets/bird3.png',
  ),
  Animal(
    type: AnimalType.land,
    imageUrl: 'assets/animal3.png',
  ),
];

class ChildId {
  late int child_id;

  int get getChildId {
    return child_id;
  }

  set setChildId(int childid) {
    child_id = childid;
  }
}
