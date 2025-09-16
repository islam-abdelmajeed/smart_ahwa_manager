abstract class Drink {
  String get name;
  double get basePrice;

  const Drink();

  factory Drink.named(String name) {
    switch (name.toLowerCase()) {
      case 'shai':
      case 'tea':
        return const Shai();
      case 'turkish coffee':
      case 'turkish':
        return const TurkishCoffee();
      case 'hibiscus tea':
      case 'hibiscus':
        return const HibiscusTea();
      default:
        return CustomDrink(displayName: name.trim());
    }
  }
}

class Shai extends Drink {
  const Shai();
  @override
  String get name => 'Shai (Tea)';
  @override
  double get basePrice => 10;
}

class TurkishCoffee extends Drink {
  const TurkishCoffee();
  @override
  String get name => 'Turkish Coffee';
  @override
  double get basePrice => 18;
}

class HibiscusTea extends Drink {
  const HibiscusTea();
  @override
  String get name => 'Hibiscus Tea';
  @override
  double get basePrice => 14;
}

class CustomDrink extends Drink {
  final String displayName;
  const CustomDrink({required this.displayName});
  @override
  String get name => displayName;
  @override
  double get basePrice => 12;
}
