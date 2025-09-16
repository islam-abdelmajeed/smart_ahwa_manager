import 'dart:collection';
import '../domain/order.dart';
import 'order_repository.dart';

class InMemoryOrderRepository implements OrderRepository {
  final Map<String, Order> _store = {};

  @override
  Future<void> add(Order order) async {
    _store[order.id] = order;
  }

  @override
  Future<void> update(Order order) async {
    _store[order.id] = order;
  }

  @override
  Future<Order?> getById(String id) async => _store[id];

  @override
  Future<List<Order>> all() async => _store.values.toList()..sort((a, b) => a.createdAt.compareTo(b.createdAt));

  @override
  Future<List<Order>> byStatus(OrderStatus status) async => (await all()).where((o) => o.status == status).toList();
}
