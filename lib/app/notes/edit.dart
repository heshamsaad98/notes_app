import 'package:flutter/material.dart';
import 'package:noteapp/components/crud.dart';

import '../../components/customtextform.dart';
import '../../components/valid.dart';
import '../../constant/link_api.dart';
import '../../main.dart';

class EditNotes extends StatefulWidget {
  final notes;
  const EditNotes({Key? key, this.notes}) : super(key: key);

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> with Crud {
  GlobalKey<FormState>  formState = GlobalKey<FormState>();

  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  bool isLoading = false;

  editNotes() async {
    if(formState.currentState!.validate()){
      isLoading = true;
      setState(() {

      });
      var response = await postRequest(linkEditNotes, {
        'title' : title.text,
        'content' : content.text,
        'id' : widget.notes['notes_id'].toString(),
      });
      isLoading = false;
      setState(() {

      });
      if(response['status'] == 'success'){
        Navigator.of(context).pushReplacementNamed('home');
      }else{

      }
    }
  }

  @override
  void initState() {
    title.text = widget.notes['notes_title'];
    content.text = widget.notes['notes_content'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Notes',
        ),
      ),
      body: isLoading == true ? Center(child: CircularProgressIndicator(),) : Container(
        padding: EdgeInsets.all(10),
        child: Form(
          key: formState,
          child: ListView(
            children: [
              CustTextFormSign(
                hint: 'title',
                myController: title,
                vaild: (val) {
                  return validInput(val!, 1, 40);
                },
              ),
              CustTextFormSign(
                hint: 'content',
                myController: content,
                vaild: (val) {
                  return validInput(val!, 1, 255);
                },
              ),
              Container(
                height: 20.0,
              ),
              MaterialButton(
                onPressed: () async {
                  await editNotes();
                },
                child: Text(
                  'Save',
                ),
                textColor: Colors.white,
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
