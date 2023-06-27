import 'package:flutter/material.dart';
import 'package:noteapp/app/notes/edit.dart';
import 'package:noteapp/components/cardnote.dart';
import 'package:noteapp/constant/link_api.dart';
import 'package:noteapp/main.dart';
import 'package:noteapp/model/notemodel.dart';

import '../components/crud.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with Crud {

  getNotes() async {
    var response = await postRequest(
      linkViewNotes,
      {
        'id' : sharedPref.getString('id'),
      },
    );
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
              onPressed: (){
                sharedPref.clear();
                Navigator.of(context).pushNamedAndRemoveUntil('login', (route) => false);
              },
              icon: Icon(
                Icons.exit_to_app,
              ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('addnotes');
        },
        child: Icon(
          Icons.add,
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: [
            FutureBuilder(
              future: getNotes(),
                builder: (context, AsyncSnapshot snapshot){
                  if(snapshot.hasData){
                    if(snapshot.data['status'] == 'fail') return Center(child: Text('لا يوجد ملاحظات', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),));
                    return ListView.builder(
                      itemCount: snapshot.data['data'].length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index){
                          return CardNotes(
                            onDelete: () async {
                              var response = await postRequest(linkDeleteNotes, {
                                'id' : snapshot.data['data'][index]['notes_id'].toString(),
                              },);
                              if(response['status'] == 'success'){
                                Navigator.of(context).pushReplacementNamed('home');
                              }
                            },
                              onTap: (){
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => EditNotes(
                                        notes: snapshot.data['data'][index],
                                      ),
                                  ),
                                );
                              },
                              notemodel: NoteModel.fromJson(snapshot.data['data'][index]),
                          );
                        },
                    );
                  }
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: Text('Loading...'),);
                  }
                  return Center(child: Text('Loading...'),);
                },
            ),
          ],
        ),
      ),
    );
  }
}
