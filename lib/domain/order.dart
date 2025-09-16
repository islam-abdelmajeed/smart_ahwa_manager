import 'drink.dart';
import 'extra.dart';

enum OrderStatus { pending, completed }

class Order {
  final String id;
  final String customerName;
  final Drink drink;
  final List<Extra> extras;
  final String specialInstructions;
  final DateTime createdAt;
  OrderStatus _status;

  Order({
    required this.id,
    required this.customerName,
    required this.drink,
    List<Extra>? extras,
    this.specialInstructions = '',
    DateTime? createdAt,
    OrderStatus status = OrderStatus.pending,
  })  : createdAt = createdAt ?? DateTime.now(),
        extras = List.unmodifiable(extras ?? const []),
        _status = status {
    if (customerName.trim().isEmpty) {
      throw ArgumentError('Customer name cannot be empty.');
    }
  }

  OrderStatus get status => _status;

  double get totalPrice => drink.basePrice + extras.fold(0.0, (sum, e) => sum + e.price);

  void markCompleted() {
    if (_status == OrderStatus.completed) return;
    _status = OrderStatus.completed;
  }

  @override
  String toString() {
    final extrasLabel = extras.isEmpty ? 'none' : extras.map((e) => e.name).join(', ');
    return '#$id | $customerName → ${drink.name} '
        '(extras: $extrasLabel) '
        '${specialInstructions.isEmpty ? "" : "[$specialInstructions]"} '
        'EGP ${totalPrice.toStringAsFixed(2)} '
        '| ${status.name}';
  }
}
