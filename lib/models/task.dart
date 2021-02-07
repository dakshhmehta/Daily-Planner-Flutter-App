import 'package:flutter/material.dart';

class Task {
  String title;
  String status = 'incomplete';

  Task(String title) {
    this.title = title;
  }

  void changeStatus(String s) {
    status = s;
  }

  Widget getIcon() {
    if (this.status == 'completed') {
      return Icon(
        Icons.check,
        color: Colors.green[400],
      );
    }
    if (this.status == 'later') {
      return Icon(
        Icons.arrow_right_alt_sharp,
        color: Colors.blue[400],
      );
    }
    if (this.status == 'cancelled') {
      return Icon(
        Icons.close,
        color: Colors.red[400],
      );
    }
    return Icon(
      Icons.check_box_outline_blank,
      color: Colors.grey[400],
    );
  }
}
