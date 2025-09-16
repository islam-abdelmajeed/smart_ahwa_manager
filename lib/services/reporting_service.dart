import 'dart:collection';
import '../domain/order.dart';
import '../repo/order_repository.dart';

class ReportingService {
  final OrderRepository repo;
  ReportingService(this.repo);

  Future<int> totalOrders() async => (await repo.all()).length;

  Future<LinkedHashMap<String, int>> topSelling({int top = 5}) async {
    final orders = await repo.all();
    final counter = <String, int>{};
    for (final o in orders) {
      counter.update(o.drink.name, (v) => v + 1, ifAbsent: () => 1);
    }
    final sorted = counter.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    final take = top <= 0 ? sorted : sorted.take(top);
    return LinkedHashMap.fromEntries(take);
  }
}
