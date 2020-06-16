import 'package:flutter/material.dart';
import 'package:fluttergallery/utils/utils.dart';

extension StringExtension on String {

  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}