import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'To-Do List',
  home: TodoList(),
  theme: ThemeData(
    primarySwatch: Colors.red,
  ),);
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final List<String> _todoList = <String>[];
  final TextEditingController _textFieldController = TextEditingController();
   final Map<String, bool> _completionStatus = {};
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FlexibleSpaceBar(
          centerTitle: true,
          title: Text('To-Do List'),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(children: _getItems()),
          ),
          Padding(
            padding: const EdgeInsets.all(15.20),
            child: ElevatedButton(
              onPressed: _deleteCompletedItems,
              child: Text('Seçilen Görevleri Sil'),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _displayDialog(context),
          tooltip: 'Add Item',
          child: Icon(Icons.add)),
    );
  }
  void _deleteCompletedItems() {
  setState(() {
    _todoList.removeWhere((item) => _completionStatus[item] == true);
  });
}

  void _addTodoItem(String title) {
    
    
    setState(() {
      _todoList.add(title);
    });
    _textFieldController.clear();
  }
void _deleteTodoItem(String title) {
  setState(() {
    _todoList.remove(title);
  });
}
  
 
  bool _isCompleted(String title) {
  return _completionStatus[title] ?? false;
}

void _markAsCompleted(String title, bool? value) {
  setState(() {
    _completionStatus[title] = value ?? false;
  });
}
 Widget _buildTodoItem(String title) {
   final bool isCompleted = _isCompleted(title);
  final TextDecoration decoration = isCompleted ? TextDecoration.lineThrough : TextDecoration.none;
  final TextStyle style = TextStyle(decoration: decoration);

  return CheckboxListTile(
    title: Text(title, style: style),
    value: isCompleted,
    onChanged: (bool? value) {
      _markAsCompleted(title, value);
    },
    controlAffinity: ListTileControlAffinity.leading,
  );
   return Container(
    margin: const EdgeInsets.symmetric(vertical: 25.10),
    child: CheckboxListTile(
      title: Text(title),
      value: _completionStatus[title] ?? false,
      onChanged: (bool? value) {
        _markAsCompleted(title, value);
      },
      controlAffinity: ListTileControlAffinity.leading,
    ),
  );

}

  
  Future<Future> _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Yapılacak Görev Ekleyin'),
            content: TextField(
              controller: _textFieldController,
              decoration: const InputDecoration(hintText: 'Buraya Görev Ekleyin'),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Ekle'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _addTodoItem(_textFieldController.text);
                },
              ),
              ElevatedButton(
                child: const Text('İptal '),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  List<Widget> _getItems() {
    final List<Widget> _todoWidgets = <Widget>[];
    for (String title in _todoList) {
      _todoWidgets.add(_buildTodoItem(title));
    }
    return _todoWidgets;
  }
}