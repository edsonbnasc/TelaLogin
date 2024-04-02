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
                  onPressed: () {
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Tarefas Pendentes:'),
                  Expanded(
                    child: ListView.builder(
                      itemCount: tarefasPendentes.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: Key(tarefasPendentes[index]['tarefa']),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            setState(() {
                              tarefasConcluidas.add(tarefasPendentes[index]);
                              tarefasPendentes.removeAt(index);
                            });
                          },
                          background: Container(
                            alignment: AlignmentDirectional.centerEnd,
                            color: Colors.green,
                            child: Icon(Icons.check),
                          ),
                          child: ListTile(
                            title: Text(tarefasPendentes[index]['tarefa']),
                            trailing: IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                _editTarefa(index);
                              },
                            ),
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
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                tarefasConcluidas.removeAt(index);
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

   void _deleteTarefa(int index) {
    setState(() {
      tarefasPendentes.removeAt(index);
    });
  }

  void _toggleConcluida(int index) {
    setState(() {
      tarefasPendentes[index]['concluida'] = !tarefasPendentes[index]['concluida'];
    });
  }

  void _editTarefa(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController editingController =
            TextEditingController(text: tarefasPendentes[index]['tarefa']);
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
                  tarefasPendentes[index]['tarefa'] = editingController.text;
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
}