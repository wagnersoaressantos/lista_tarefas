import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lista_tarefas/page/main/app.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const App());
}
