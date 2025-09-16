class Extra {
  final String name;
  final double price;

  const Extra(this.name, {this.price = 2});

  @override
  String toString() => '$name${price > 0 ? " (+$price)" : ""}';
}
