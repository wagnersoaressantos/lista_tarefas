import 'package:lista_tarefas/model/tarefas_modelo.dart';

import 'tarefas_custom.dart';

class TarefasRepositoy {
  final _custonDio = TarefasCustom();

  TarefasRepositoy();

  Future<TarefasModelo> obterTarefas(bool naoConcluidas) async {
    var url = "/lista_de_tarefas";
    if (naoConcluidas) {
      url = "$url?where={\"concluido\":false}";
    }
    var result = await _custonDio.dio.get(url);
    return TarefasModelo.fromJson(result.data);
  }

  Future<void> criar(TarefaModelo tarefaModelo) async {
    try {
      await _custonDio.dio.post(
        "/lista_de_tarefas",
        data: tarefaModelo.toJsonEndPoint(),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> atualizar(TarefaModelo tarefaModelo) async {
    try {
      await _custonDio.dio.put(
        "/lista_de_tarefas/${tarefaModelo.objectId}",
        data: tarefaModelo.toJsonEndPoint(),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> remover(String objectId) async {
    try {
      await _custonDio.dio.delete("/lista_de_tarefas/$objectId");
    } catch (e) {
      rethrow;
    }
  }
}
