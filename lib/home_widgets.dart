import 'package:flutter/material.dart';

import 'const.dart';

Widget myImage() {
  return Container(
    height: 200,
    width: 200,
    decoration: BoxDecoration(
      image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(image1)),
      color: Colors.grey,
      borderRadius: BorderRadius.circular(100),
    ),
  );
}

Widget myAppBar() {
  return Container(
    height: 150,
    width: double.infinity,
    color: Colors.blue,
    child: Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 80.0),
        child: Text(
          "My Profile",
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}
