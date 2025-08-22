import 'package:flutter/material.dart';
import 'package:lista_tarefas/model/tarefas_modelo.dart';
import 'package:lista_tarefas/repository/tarefas_repository.dart';
import 'package:provider/provider.dart';

class TarefaPage extends StatelessWidget {
  var descricaoContoller = TextEditingController();

  TarefaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tarefaRepo = Provider.of<TarefasRepositoy>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: Text("Tarefas"), centerTitle: true),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          descricaoContoller.text = "";
          showDialog(
            context: context,
            builder: (BuildContext bc) {
              return AlertDialog(
                title: const Text("Adicionar tarefa"),
                content: TextField(controller: descricaoContoller),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancelar"),
                  ),
                  TextButton(
                    onPressed: () async {
                      tarefaRepo.criar(
                        TarefaModelo.criar(descricaoContoller.text, false),
                      );
                      Navigator.pop(context);
                    },
                    child: const Text("Salvar"),
                  ),
                ],
              );
            },
          );
        },
      ),
      body: Consumer<TarefasRepositoy>(
        builder: (context, tarefasRepositoy, widget) {
          if (tarefasRepositoy.carregando) {
            return const Center(child: CircularProgressIndicator());
          }

          if (tarefasRepositoy.tarefas.isEmpty) {
            return Center(
              child: Text(
                "Nenhuma tarefa cadastrada",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Apenas não concluídos",
                        style: TextStyle(fontSize: 18),
                      ),
                      Consumer<TarefasRepositoy>(
                        builder: (context, tarefasRepositoy, widget) {
                          return Switch(
                            value: tarefasRepositoy.apenasNaoConcluidos,
                            onChanged: (bool value) {
                              tarefaRepo.apenasNaoConcluidos = value;
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Consumer<TarefasRepositoy>(
                    builder: (context, tarefasRepositoy, widget) {
                      return ListView.builder(
                        itemCount: tarefasRepositoy.tarefas.length,
                        itemBuilder: (BuildContext bc, int index) {
                          var tarefa = tarefasRepositoy.tarefas[index];
                          return Dismissible(
                            onDismissed:
                                (DismissDirection dismissDirection) async {
                                  tarefaRepo.remover(tarefa.objectId);
                                },
                            key: Key(tarefa.descricao),
                            child: ListTile(
                              title: Text(tarefa.descricao),
                              trailing: Switch(
                                value: tarefa.concluido,
                                onChanged: (bool value) async {
                                  tarefa.concluido = value;
                                  tarefaRepo.atualizar(tarefa);
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
