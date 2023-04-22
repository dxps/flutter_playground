import 'package:flutter3_ecomm/src/features/shopping_cart/shopping_cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter3_ecomm/src/constants/app_sizes.dart';

/// Shopping cart icon with items count badge
class ShoppingCartIcon extends StatelessWidget {
  const ShoppingCartIcon({Key? key}) : super(key: key);

  static const shoppingCartIconKey = Key('shopping-cart');

  @override
  Widget build(BuildContext context) {
    // TODO: Read from data source
    const cartItemsCount = 3;
    return Stack(
      children: [
        Center(
          child: IconButton(
            key: shoppingCartIconKey,
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (_) => const ShoppingCartScreen(),
              ),
            ),
          ),
        ),
        if (cartItemsCount > 0)
          const Positioned(
            top: Sizes.p4,
            right: Sizes.p4,
            child: ShoppingCartIconBadge(itemsCount: cartItemsCount),
          ),
      ],
    );
  }
}

/// Icon badge showing the items count
class ShoppingCartIconBadge extends StatelessWidget {
  const ShoppingCartIconBadge({Key? key, required this.itemsCount}) : super(key: key);
  final int itemsCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Sizes.p16,
      height: Sizes.p16,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
        child: Text(
          '$itemsCount',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.caption!.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
