import 'package:flutter/material.dart';
import 'package:notes_app_with_isar/Components/tile.dart';
import 'package:notes_app_with_isar/Databases/notes_db.dart';
import 'package:notes_app_with_isar/Entites/note.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotesDbService.initializeDb();

  runApp(ChangeNotifierProvider(
    create: (context) => NotesDbService(),
    child: const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    ),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController editingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isExpanded = false;

  void createNote() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Create a note'),
          content: Form(
            key: _formKey,
            child: TextFormField(
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Note cannot be empty';
                }
                return null;
              },
              controller: _controller,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _controller.clear();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  context.read<NotesDbService>().addNotes(_controller.text);
                  _controller.clear();
                  Navigator.of(context).pop();
                } else {
                  //_formKey.currentState?.validate();
                }
              },
              child: const Text('Create'),
            ),
          ],
        );
      },
    );
  }

  void fetchNOtes() {
    context.read<NotesDbService>().readNotes();
  }

  void deleteNOte(int id) {
    context.read<NotesDbService>().deleteNote(id);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchNOtes();
  }

  @override
  Widget build(BuildContext context) {
    //fetchNOtes();
    final NotesDbService notesDb = context.watch<NotesDbService>();
    List<Note> notes =
        notesDb.getNotes(); // get the list of notes from the database
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.yellow[500],
      ),
      debugShowCheckedModeBanner: false,
      home: SafeArea(
          child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            'N O T E S',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        // backgroundColor: Colors.white70,
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(2),
                itemBuilder: (context, index) {
                  final Note note = notes[index];
                  return MyTile(
                    noteId: note.id,
                    text: note.text!,
                    editingFun: () {
                      updatingNOte(note);
                    },
                    deletingfun: () => deleteNOte(note.id),
                  );
                },
                itemCount: notes.length,
              ),
            ),
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 20, right: 16),
          child: FloatingActionButton(
            onPressed: createNote,
            child: const Icon(Icons.add),
          ),
        ),
      )),
    );
  }

  void updatingNOte(Note note) {
    editingController.text = note.text ?? '';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update Note'),
          content: TextField(
            controller: editingController,
          ),
          actions: [
            TextButton(
              onPressed: () {
                editingController.clear();
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context
                    .read<NotesDbService>()
                    .updateNote(note.id, editingController.text);
                Navigator.of(context).pop();
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }
}
