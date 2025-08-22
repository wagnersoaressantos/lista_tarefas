class TarefasModelo {
  List<TarefaModelo> tarefas = [];

  TarefasModelo(this.tarefas);

  TarefasModelo.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      tarefas = <TarefaModelo>[];
      json['results'].forEach((v) {
        tarefas.add(TarefaModelo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = tarefas.map((v) => v.toJson()).toList();
    return data;
  }
}

class TarefaModelo {
  String objectId = "";
  String descricao = "";
  bool concluido = false;
  String createdAt = "";
  String updatedAt = "";

  TarefaModelo(
    this.objectId,
    this.descricao,
    this.concluido,
    this.createdAt,
    this.updatedAt,
  );
  TarefaModelo.criar(
    this.descricao,
    this.concluido,
  );

  TarefaModelo.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    descricao = json['descricao'];
    concluido = json['concluido'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['descricao'] = descricao;
    data['concluido'] = concluido;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
  Map<String, dynamic> toJsonEndPoint() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['descricao'] = descricao;
    data['concluido'] = concluido;
    return data;
  }
}
