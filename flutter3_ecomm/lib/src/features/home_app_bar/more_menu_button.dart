import 'package:flutter3_ecomm/src/features/account/account_screen.dart';
import 'package:flutter3_ecomm/src/features/orders_list/orders_list_screen.dart';
import 'package:flutter3_ecomm/src/features/sign_in/email_password_sign_in_screen.dart';
import 'package:flutter3_ecomm/src/features/sign_in/email_password_sign_in_state.dart';
import 'package:flutter3_ecomm/src/localization/string_hardcoded.dart';
import 'package:flutter/material.dart';
import 'package:flutter3_ecomm/src/models/app_user.dart';

enum PopupMenuOption {
  signIn,
  orders,
  account,
}

class MoreMenuButton extends StatelessWidget {
  const MoreMenuButton({Key? key, this.user}) : super(key: key);
  final AppUser? user;

  static const signInKey = Key('menuSignIn');
  static const ordersKey = Key('menuOrders');
  static const accountKey = Key('menuAccount');

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      // three vertical dots icon (to reveal menu options)
      icon: const Icon(Icons.more_vert),
      itemBuilder: (_) {
        // show all the options based on conditional logic
        return user != null
            ? <PopupMenuEntry<PopupMenuOption>>[
                PopupMenuItem(
                  key: ordersKey,
                  child: Text('Orders'.hardcoded),
                  value: PopupMenuOption.orders,
                ),
                PopupMenuItem(
                  key: accountKey,
                  child: Text('Account'.hardcoded),
                  value: PopupMenuOption.account,
                ),
              ]
            : <PopupMenuEntry<PopupMenuOption>>[
                PopupMenuItem(
                  key: signInKey,
                  child: Text('Sign In'.hardcoded),
                  value: PopupMenuOption.signIn,
                ),
              ];
      },
      onSelected: (option) {
        // push to different routes based on selected option
        switch (option) {
          case PopupMenuOption.signIn:
            Navigator.of(context).push(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (_) => const EmailPasswordSignInScreen(
                  formType: EmailPasswordSignInFormType.signIn,
                ),
              ),
            );
            break;
          case PopupMenuOption.orders:
            Navigator.of(context).push(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (_) => const OrdersListScreen(),
              ),
            );
            break;
          case PopupMenuOption.account:
            Navigator.of(context).push(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (_) => const AccountScreen(),
              ),
            );
            break;
        }
      },
    );
  }
}
