import 'package:flutter/material.dart';
import 'package:lista_tarefas/page/tarefa/tarefa_page.dart';
import 'package:lista_tarefas/service/dark_mode_service.dart';
import 'package:lista_tarefas/service/imagem_padrao.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var darkMode = Provider.of<DarkModeService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas',),
        centerTitle: true,
        actions: [
          Row(
            children: [
              Icon(Icons.light_mode),
              Consumer<DarkModeService>(
                builder: (context, darkModeService, widget) {
                  return Switch(
                    value: darkMode.darkMode,
                    onChanged: (value) {
                      darkMode.darkMode = !darkMode.darkMode;
                    },
                  );
                }
              ),
              Icon(Icons.dark_mode),
            ],
          ),
        ],
      ),
      body: Container(
        color: Colors.blue,
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TarefaPage()),
                      );
                    },
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Image.asset(ImagemPadrao.lista_tarefas),
                            ),
                            Text("lista de Tarefa"),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => ListaContatoPagina(),
                  //       ),
                  //     );
                  //   },
                  //   child: Card(
                  //     child: Container(
                  //       padding: EdgeInsets.all(16),
                  //       child: Column(
                  //         children: [
                  //           Expanded(
                  //             flex: 1,
                  //             child: Image.asset(ImagemPadrao.lista_contato),
                  //           ),
                  //           Text("Lista de Contato"),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            Expanded(flex: 3, child: Container()),
          ],
        ),
      ),
    );
  }
}
