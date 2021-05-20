// profile 표시하는 widget
import 'dart:io';

import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final bool isEdit;
  final VoidCallback onClicked;

  const ProfileWidget({
    Key key,
    @required this.imagePath,
    this.isEdit = false,
    @required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final color = Theme.of(context).colorScheme.primary;

    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(bottom: 0, right: 4, child: buildEditIcon(Colors.blue)),
        ],
      ),
    );
  }

  Widget buildImage() {
    final image = NetworkImage(imagePath);

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 130,
          height: 130,
          // child: InkWell(
          //   onTap: onClicked,
          // ),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => ClipOval(
        child: Material(
          color: Colors.green,
          child: SizedBox(
            height: 35.0,
            width: 35.0,
            child: IconButton(
              padding: EdgeInsets.all(0.0),
              icon: isEdit
                  ? const Icon(Icons.camera_alt)
                  : const Icon(Icons.edit),
              color: Colors.white,
              iconSize: 20,
              onPressed: () {
                onClicked();
              },
            ),
          ),
        ),
      );
}
