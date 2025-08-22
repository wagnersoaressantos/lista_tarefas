import 'package:flutter/material.dart';
import 'package:lista_tarefas/page/tarefa/tarefa_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
                            // Expanded(child: Container()),
                            // Expanded(
                            //   flex: 1,
                            //   child: Image.asset(ImagemPadrao.criar_contato),
                            // ),
                            // Expanded(child: Container()),
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
