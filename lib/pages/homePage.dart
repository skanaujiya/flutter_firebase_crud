import 'package:flutter/material.dart';
import 'package:flutter_firestore_crud/pages/add_student_page.dart';
import 'list_student_page.dart';

class HomePage extends StatefulWidget{
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState()=>_HomePageState();
}

class _HomePageState extends State<HomePage>{

  @override
  Widget build(BuildContext context)=>Scaffold(
    appBar: AppBar(
      title: const Text("CRUD"),
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    floatingActionButton: FloatingActionButton(
      backgroundColor: Colors.red,
      onPressed: ()=>{
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context)=> AddStudentPage()
            ))
      },
      elevation: 20 ,
      splashColor: Colors.blue,
      child: const Icon(Icons.add),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      )
    ),
    body: ListStudentPage(),
  );
}