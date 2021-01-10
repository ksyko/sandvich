import 'package:flutter/material.dart';
import 'package:sandvich/dimens/dimens.dart';

class InfoCard extends StatelessWidget {
  final IconData iconData;
  final String header;
  final String body;
  final Function function;

  InfoCard(this.iconData, this.header, this.body, [this.function]);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Card(
        child: InkWell(
          onTap: function,
          child: Row(
            children: [
              if (iconData != null)
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Icon(
                      iconData,
                      size: 50,
                    ),
                  ),
                ),
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        header,
                        style: Dimens.headline6.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (body != null && body.isNotEmpty)
                        Text(
                          body,
                          style: Dimens.subtitle1,
                        ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
