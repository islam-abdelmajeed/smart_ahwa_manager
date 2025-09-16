import 'package:test/test.dart';
import 'package:smart_ahwa_manager/domain/order.dart';
import 'package:smart_ahwa_manager/domain/drink.dart';

void main() {
  test('Order calculates total price correctly', () {
    final order = Order(
      id: '1',
      customerName: 'Ahmed',
      drink: const TurkishCoffee(),
    );

    expect(order.totalPrice, 18); // base price of Turkish Coffee
  });
}
