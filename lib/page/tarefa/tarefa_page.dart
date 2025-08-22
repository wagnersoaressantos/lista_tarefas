import 'package:flutter/material.dart';
import 'package:lista_tarefas/model/tarefas_modelo.dart';
import 'package:lista_tarefas/repository/tarefas_repository.dart';

class TarefaPage extends StatefulWidget {
  const TarefaPage({super.key});

  @override
  State<TarefaPage> createState() => _TarefaPageState();
}

class _TarefaPageState extends State<TarefaPage> {
  TarefasRepositoy tarefaRepository = TarefasRepositoy();
  var _tarefas = TarefasModelo([]);
  var descricaoContoller = TextEditingController();
  var apenasNaoConcluidos = false;
  var carregando = false;

  @override
  void initState() {
    super.initState();
    obterTarefas();
  }

  void obterTarefas() async {
    setState(() {
      carregando = true;
    });
    _tarefas = await tarefaRepository.obterTarefas(apenasNaoConcluidos);
    setState(() {
      carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                      await tarefaRepository.criar(
                        TarefaModelo.criar(descricaoContoller.text, false),
                      );
                      Navigator.pop(context);
                      obterTarefas();
                      setState(() {});
                    },
                    child: const Text("Salvar"),
                  ),
                ],
              );
            },
          );
        },
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Apenas não concluídos",
                    style: TextStyle(fontSize: 18),
                  ),
                  Switch(
                    value: apenasNaoConcluidos,
                    onChanged: (bool value) {
                      apenasNaoConcluidos = value;
                      obterTarefas();
                    },
                  ),
                ],
              ),
            ),
            carregando
                ? CircularProgressIndicator()
                : Expanded(
                    child: ListView.builder(
                      itemCount: _tarefas.tarefas.length,
                      itemBuilder: (BuildContext bc, int index) {
                        var tarefa = _tarefas.tarefas[index];
                        return Dismissible(
                          onDismissed:
                              (DismissDirection dismissDirection) async {
                                await tarefaRepository.remover(tarefa.objectId);
                                obterTarefas();
                              },
                          key: Key(tarefa.descricao),
                          child: ListTile(
                            title: Text(tarefa.descricao),
                            trailing: Switch(
                              onChanged: (bool value) async {
                                tarefa.concluido = value;
                                await tarefaRepository.atualizar(tarefa);
                                obterTarefas();
                              },
                              value: tarefa.concluido,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
