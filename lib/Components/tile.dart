import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notes_app_with_isar/Databases/notes_db.dart'; // Adjust import based on your project structure

class MyTile extends StatelessWidget {
  final String text;
  final int noteId; // Add noteId to identify which note this tile represents
  final Function() editingFun;
  final Function() deletingfun;

  const MyTile({
    super.key,
    required this.text,
    required this.noteId,
    required this.editingFun,
    required this.deletingfun,
  });

  @override
  Widget build(BuildContext context) {
    final notesDbService = Provider.of<NotesDbService>(context);
    bool isChecked = notesDbService.isNoteChecked(noteId);

    return Container(
      
      padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(12),
        color: const Color.fromARGB(255, 33, 20, 20),
      ),
      child: ListTile(
        title: Flexible(
          child: RichText(
            text: TextSpan(
              text: text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white,
                decoration: isChecked
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                decorationColor: isChecked ? Colors.white : Colors.transparent,
                decorationThickness: 2, // Adjust thickness as needed
              ),
            ),
          ),
        ),
        leading:  Checkbox(
             
              value: isChecked,
              onChanged: (bool? value) {
                if (value != null) {
                  notesDbService.toggleNoteChecked(noteId);
                }
              },
            ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: editingFun,
                icon: const Icon(
                  Icons.edit,
                  color: Color.fromARGB(255, 241, 208, 208),
                )),
            IconButton(
              onPressed: deletingfun,
              icon: const Icon(
                Icons.delete,
                color: Color.fromARGB(255, 241, 208, 208),
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}
