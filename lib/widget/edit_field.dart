import 'package:flutter/material.dart';

class EditField extends StatelessWidget {
  final String title;
  final IconData iconData;
  final TextEditingController controller;
  final FocusNode focusNode;

  EditField(
    this.title,
    this.iconData,
    this.controller,
    this.focusNode,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Card(
        child: InkWell(
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Icon(
                        iconData,
                        size: 35,
                      ),
                      if (title != null) Text(title)
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    style: TextStyle(fontSize: 22),
                    controller: controller,
                    focusNode: focusNode,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
