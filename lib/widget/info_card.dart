import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final IconData iconData;
  final String header;
  final String body;
  final Function function;

  InfoCard(this.iconData, this.header, this.body, [this.function]);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: InkWell(
        onTap: function,
        child: Card(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(
                  iconData,
                  size: 50,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      header,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    if (body != null && body.isNotEmpty)
                      Text(
                        body,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
