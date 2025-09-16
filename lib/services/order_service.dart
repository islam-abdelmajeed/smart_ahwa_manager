import 'dart:math';
import '../domain/drink.dart';
import '../domain/extra.dart';
import '../domain/order.dart';
import '../repo/order_repository.dart';

class OrderService {
  final OrderRepository repo;
  OrderService(this.repo);

  Future<Order> addOrder({
    required String customerName,
    required String drinkName,
    List<Extra>? extras,
    String specialInstructions = '',
  }) async {
    final id = _generateId();
    final order = Order(
      id: id,
      customerName: customerName,
      drink: Drink.named(drinkName),
      extras: extras,
      specialInstructions: specialInstructions,
    );
    await repo.add(order);
    return order;
  }

  Future<bool> completeOrder(String id) async {
    final order = await repo.getById(id);
    if (order == null) return false;
    order.markCompleted();
    await repo.update(order);
    return true;
  }

  Future<List<Order>> pendingDashboard() => repo.byStatus(OrderStatus.pending);

  String _generateId() => DateTime.now().millisecondsSinceEpoch.toString().substring(7) + Random().nextInt(999).toString().padLeft(3, '0');
}
