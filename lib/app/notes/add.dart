import 'package:flutter/material.dart';
import 'package:noteapp/components/customtextform.dart';
import 'package:noteapp/components/valid.dart';
import 'package:noteapp/constant/link_api.dart';
import 'package:noteapp/main.dart';

import '../../components/crud.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({Key? key}) : super(key: key);

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> with Crud{

  GlobalKey<FormState>  formState = GlobalKey<FormState>();

  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  bool isLoading = false;

  addNotes() async {
    if(formState.currentState!.validate()){
      isLoading = true;
      setState(() {

      });
      var response = await postRequest(linkAddNotes, {
        'title' : title.text,
        'content' : content.text,
        'id' : sharedPref.getString('id'),
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Notes',
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
                  await addNotes();
                },
                child: Text(
                  'Add',
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
