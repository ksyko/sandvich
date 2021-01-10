import 'package:flutter/material.dart';

Card contentTile(
    BuildContext context, String route, String title, IconData icon) {
  return Card(
    child: InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        padding: EdgeInsets.only(left: 8, right: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                child: Icon(
                  icon,
                  size: 36,
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                width: 4,
              ),
            ),
            Expanded(
              flex: 4,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
