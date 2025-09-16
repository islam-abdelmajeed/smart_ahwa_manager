import '../domain/order.dart';

abstract class OrderRepository {
  Future<void> add(Order order);
  Future<void> update(Order order);
  Future<Order?> getById(String id);
  Future<List<Order>> all();
  Future<List<Order>> byStatus(OrderStatus status);
}
