import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const HomeScreen(
      {super.key, required this.isDarkMode, required this.toggleTheme});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _titleEditingController = TextEditingController();
  final TextEditingController _descriptionEditingController =
      TextEditingController();
  List<Todo> todos = [];

  GlobalKey<FormState> todoForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () {
              todos.clear();
              if (mounted) {
                setState(() {});
              }
            },
            icon: const Icon(Icons.playlist_remove),
          ),
          IconButton(
            onPressed: widget.toggleTheme,
            icon: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode),
          ),
        ],
      ),
      body: ListView.separated(
      body: ListView.separated(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            onLongPress: () {
              todos[index].isDone = !todos[index].isDone;
              if (mounted) {
                setState(() {});
              }
            },
            /// visibility is better than ternary operator
            leading: Visibility(
              visible: todos[index].isDone,
              replacement: const Icon(Icons.close),
              child: const Icon(Icons.done),
            ),
            //      todos[index].isDone
            //     ? const Icon(Icons.done)
            //     : const Icon(Icons.close),
            title: Text(todos[index].title),
            subtitle: Text(todos[index].description),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () {
                    todos.removeAt(index);
                    if (mounted) {
                      setState(() {});
                    }
                  },
                  icon: const Icon(Icons.delete_forever_outlined),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddNewTodoModelSheet();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void showAddNewTodoModelSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: todoForm,
            child: Column(
              children: [
                const Text(
                  'Add new todo',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _titleEditingController,
                  validator: (value) {
                    if(value?.trim().isEmpty ?? true){
                      return 'Please enter your title';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    hintText: 'Title',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: TextFormField(
                    controller: _descriptionEditingController,
                    validator: (value) {
                      if(value?.trim().isEmpty ?? true){
                        return 'Please enter your description';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      hintText: 'Description',
                    ),
                  ),
                ),
                ElevatedButton(
                  style: const ButtonStyle(
                    fixedSize: WidgetStatePropertyAll(Size(double.maxFinite, 50)),
                    //backgroundColor: WidgetStatePropertyAll(Colors.ora nge),
                  ),
                  onPressed: () {
                    if ( todoForm.currentState!.validate()) {
                      todos.add(
                        Todo(_titleEditingController.text.trim(),
                            _descriptionEditingController.text.trim(), false),
                      );
                      if (mounted) {
                        setState(() {});
                      }
                      _titleEditingController.clear();
                      _descriptionEditingController.clear();
                      Navigator.pop(context);
                    } else {}
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class Todo {
  String title, description;
  bool isDone;

  Todo(this.title, this.description, this.isDone);
}
