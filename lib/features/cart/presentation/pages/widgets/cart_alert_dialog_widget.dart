import 'package:bingo/config/theme_app.dart';
import 'package:flutter/material.dart';

class CartAlertDialogWidget extends StatelessWidget {
  const CartAlertDialogWidget({super.key, required this.isCloseDismissible});

  final bool isCloseDismissible;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => isCloseDismissible,
      child: AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        elevation: 0.0,
        content: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Column(
                children: [
                  if (isCloseDismissible)
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {},
                        child: const Icon(Icons.cancel_outlined),
                      ),
                    ),
                  Image.asset('assets/images/onboarding3.png'),
                  Text(
                    'Thank you for ordering from us..!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      color: lightTheme.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

Future<void> showAlertDialog(
  BuildContext context, {
  bool scrollable = false,
  isCloseDismissible = false,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: isCloseDismissible,
    builder: (_) =>
        CartAlertDialogWidget(isCloseDismissible: isCloseDismissible),
  );
}
