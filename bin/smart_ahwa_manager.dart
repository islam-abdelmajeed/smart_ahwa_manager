import 'dart:io';
import 'package:smart_ahwa_manager/domain/extra.dart';
import 'package:smart_ahwa_manager/repo/in_memory_order_repository.dart';
import 'package:smart_ahwa_manager/services/order_service.dart';
import 'package:smart_ahwa_manager/services/reporting_service.dart';
import 'package:smart_ahwa_manager/utils/cli_helpers.dart';

void main(List<String> args) async {
  final repo = InMemoryOrderRepository();
  final orders = OrderService(repo);
  final reports = ReportingService(repo);

  print('=== Smart Ahwa Manager (Console) ===');
  print('Commands: add, complete, pending, all, report, help, quit');

  while (true) {
    stdout.write('\n> ');
    final input = stdin.readLineSync();
    if (input == null) continue;

    final parts = input.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) continue;

    final cmd = parts.first.toLowerCase();

    switch (cmd) {
      case 'add':
        final name = argValue(parts, 1) ?? prompt('Customer name');
        final drink = argValue(parts, 2) ?? prompt('Drink (Shai, Turkish, Hibiscus)');
        final extrasStr = namedArg(parts, 'extras') ?? '';
        final note = namedArg(parts, 'note') ?? '';
        final extras = extrasStr.split(',').map((s) => s.trim()).where((s) => s.isNotEmpty).map((e) => Extra(e.replaceAll('_', ' '))).toList();

        final order = await orders.addOrder(
          customerName: name,
          drinkName: drink,
          extras: extras,
          specialInstructions: note,
        );
        print('Added: $order');
        break;

      case 'complete':
        final id = argValue(parts, 1) ?? prompt('Order ID');
        final ok = await orders.completeOrder(id);
        print(ok ? 'Order $id completed.' : 'Order $id not found.');
        break;

      case 'pending':
        final items = await orders.pendingDashboard();
        if (items.isEmpty) {
          print('No pending orders. ✅');
        } else {
          print('Pending orders:');
          for (final o in items) {
            print('  $o');
          }
        }
        break;

      case 'all':
        final all = await repo.all();
        if (all.isEmpty) {
          print('No orders yet.');
        } else {
          print('All orders:');
          for (final o in all) {
            print('  $o');
          }
        }
        break;

      case 'report':
        final total = await reports.totalOrders();
        final popular = await reports.topSelling(top: 5);
        print('--- Sales Report ---');
        print('Total orders: $total');
        if (popular.isEmpty) {
          print('No sales data yet.');
        } else {
          print('Top drinks:');
          popular.forEach((drink, count) {
            print('  $drink: $count');
          });
        }
        break;

      case 'help':
        print('Examples:');
        print('  add Ahmed "Turkish Coffee" extras=extra_mint,rais note="no sugar"');
        print('  complete 123456');
        print('  pending | all | report | quit');
        break;

      case 'quit':
      case 'exit':
        print('Goodbye 👋');
        return;

      default:
        print('Unknown command. Type "help".');
    }
  }
}
