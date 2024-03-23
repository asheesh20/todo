import 'package:flutter/material.dart';
import 'package:todo/utils/colors.dart';

class DialogBox extends StatelessWidget {
  const DialogBox({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: grey100,
      content: Container(
        height: 180,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Icon(Icons.cancel),
            Divider(),
            SizedBox(
              height: 14,
            ),
            Text(
              'Are you sure want to Delete Todo ?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(),
            Row(
              children: [
                //ElevatedButton(onPressed: () {}, child: child)
              ],
            )
          ],
        ),
      ),
    );
  }
}
