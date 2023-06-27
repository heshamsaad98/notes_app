import 'package:flutter/material.dart';
import 'package:noteapp/model/notemodel.dart';

class CardNotes extends StatelessWidget {
  final void Function()? onTap;
  final NoteModel notemodel;
  final void Function()? onDelete;

  const CardNotes({Key? key, required this.onTap, required this.notemodel, this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 100.0,
                  height: 100.0,
                  fit: BoxFit.fill,
                )),
            Expanded(
                flex: 2,
                child: ListTile(
                  title: Text('${notemodel.notesTitle}'),
                  subtitle: Text('${notemodel.notesContent}'),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                    ),
                    onPressed: onDelete,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
