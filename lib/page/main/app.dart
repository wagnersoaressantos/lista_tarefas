import 'package:flutter/material.dart';
import 'package:lista_tarefas/page/home/home_page.dart';
import 'package:lista_tarefas/repository/tarefas_repository.dart';
import 'package:lista_tarefas/service/dark_mode_service.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DarkModeService>(
          create: (context) => DarkModeService(),
        ),
        ChangeNotifierProvider<TarefasRepositoy>(
          create: (context) => TarefasRepositoy()..obterTarefas(),
        ),
      ],
      child: Consumer<DarkModeService>(
        builder: (context, darkModeService, widget) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: darkModeService.darkMode
                ? ThemeData.dark()
                : ThemeData.light(),
            home: HomePage(),
          );
        },
      ),
    );
  }
}
