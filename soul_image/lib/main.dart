import 'package:flutter/material.dart';
import 'package:soul_image/core/app.dart';
import 'package:soul_image/locator_service.dart' as locator_service;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await locator_service.init();
  runApp(const SoulImageApp());
}
