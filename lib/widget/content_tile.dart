import 'package:flutter/material.dart';
import 'package:sandvich/dimens/dimens.dart';

Card contentTile(
    BuildContext context, String route, String title, IconData icon) {
  return Card(
    child: InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        padding: EdgeInsets.only(top: 8, bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 2,
              child: Container(
                child: Icon(
                  icon,
                  size: 36,
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: SizedBox(
                height: 32,
              ),
            ),
            Flexible(
              flex: 5,
              child: Text(
                title,
                style: Dimens.subtitle1,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
