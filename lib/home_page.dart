import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> tarefasPendentes = [];
  List<Map<String, dynamic>> tarefasConcluidas = [];

  final TextEditingController tarefaController = TextEditingController();
  final TextEditingController pesquisaController = TextEditingController();
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> tarefasFiltradas = tarefasPendentes.where((tarefa) {
      String termoPesquisa = pesquisaController.text.toLowerCase();
      return tarefa['tarefa'].toLowerCase().contains(termoPesquisa);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: isSearching
            ? TextField(
                controller: pesquisaController,
                decoration: InputDecoration(
                  hintText: 'Pesquisar tarefa',
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  setState(() {});
                },
              )
            : Text('Lista de Tarefas'),
        actions: <Widget>[
          IconButton(
            icon: Icon(isSearching ? Icons.cancel : Icons.search),
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
                if (!isSearching) {
                  pesquisaController.clear();
                }
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: isSearching
                      ? SizedBox()
                      : TextField(
                          controller: tarefaController,
                          decoration: InputDecoration(
                            hintText: 'Adicionar tarefa',
                          ),
                        ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: isSearching
                      ? null
                      : () {
                          setState(() {
                            tarefasPendentes.add({
                              'tarefa': tarefaController.text,
                              'concluida': false,
                            });
                            tarefaController.clear();
                          });
                        },
                ),
              ],
            ),
            isSearching
                ? Expanded(
                    child: ListView.builder(
                      itemCount: tarefasFiltradas.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(tarefasFiltradas[index]['tarefa']),
                        );
                      },
                    ),
                  )
                :  SizedBox(height: 20),
                    Text('Tarefas Pendentes:'),
                    Expanded(
                    child: ListView.builder(
                      itemCount: tarefasPendentes.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          
                          title: Text(tarefasPendentes[index]['tarefa']),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[Text('Tarefas Concluídas:'),
                              IconButton(
                                icon: Icon(tarefasPendentes[index]['concluida']
                                    ? Icons.check_box
                                    : Icons.check_box_outline_blank,color:Colors.green),
                                onPressed: () {
                                  _toggleConcluida(tarefasPendentes[index]);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  _editTarefa(tarefasPendentes[index], index);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  _delete(index);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
            SizedBox(height: 20),
            Text('Tarefas Concluídas:'),
            Expanded(
              child: ListView.builder(
                itemCount: tarefasConcluidas.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(tarefasConcluidas[index]['tarefa']),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () {
                        _deleteConcluida(index);
                      },
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

  void _toggleConcluida(Map<String, dynamic> tarefa) {
    setState(() {
      if (tarefa['concluida']) {
        tarefasConcluidas.remove(tarefa);
        tarefasPendentes.add(tarefa);
      } else {
        tarefasPendentes.remove(tarefa);
        tarefasConcluidas.add(tarefa);
      }
      tarefa['concluida'] = !tarefa['concluida'];
    });
  }

  void _editTarefa(Map<String, dynamic> tarefa, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController editingController =
            TextEditingController(text: tarefa['tarefa']);
        return AlertDialog(
          title: Text('Editar Tarefa'),
          content: TextField(
            controller: editingController,
            decoration: InputDecoration(hintText: 'Nova descrição da tarefa'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  tarefa['tarefa'] = editingController.text;
                  Navigator.pop(context);
                });
              },
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  void _delete(int index) {
    setState(() {
      tarefasPendentes.removeAt(index);
    });
  }

  void _deleteConcluida(int index) {
    setState(() {
      tarefasConcluidas.removeAt(index);
    });
  }
}