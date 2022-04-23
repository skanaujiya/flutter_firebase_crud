import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firestore_crud/pages/update_student_page.dart';

class ListStudentPage extends StatefulWidget{
  @override
  _ListStudentPage createState()=> _ListStudentPage();
}

class _ListStudentPage extends State<ListStudentPage>{
  final Stream<QuerySnapshot> _studentStream=FirebaseFirestore.instance.
  collection('students').snapshots();
  CollectionReference students=FirebaseFirestore.instance.collection('students');

  Future<void> deleteStudentData(id){
    return students
        .doc(id)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _studentStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator()
            );
          }
          final List storedoc=[];
          snapshot.data!.docs.map((DocumentSnapshot document){
            Map map=document.data() as Map<String,dynamic>;
            storedoc.add(map);
            map['id']=document.id;
          }).toList();


          return  Container(
            margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 22),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Table(
                border: TableBorder.all(),
                columnWidths: const <int,TableColumnWidth>{
                  1:FixedColumnWidth(140)
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(
                      children: [
                        TableCell(
                            child: Container(
                              color: Colors.greenAccent,
                              child: const Center(
                                child:  Text('Name',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            )
                        ),
                        TableCell(
                            child: Container(
                              color: Colors.greenAccent,
                              child: const Center(
                                child:  Text('Email',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            )
                        ),
                        TableCell(
                            child: Container(
                              color: Colors.greenAccent,
                              child: const Center(
                                child:  Text('Action',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            )
                        )
                      ]
                  ),
                  for(int i=0;i<storedoc.length;i++)...[
                    TableRow(
                        children: [
                           TableCell(
                            child: Center(child: Text(storedoc[i]['name'],
                              style: const TextStyle(fontSize: 18),
                            ),),
                          ),
                           TableCell(
                            child: Center(child: Text(storedoc[i]['email'],
                              style: const TextStyle(fontSize: 18),
                            ),),
                          ),
                          TableCell(
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: (){
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                              builder: (context)=> UpadteStudentPage(id:storedoc[i]['id']),
                                            )
                                        );
                                      },
                                      icon: const Icon(Icons.edit,color: Colors.blue,)
                                  ),
                                  IconButton(
                                      onPressed: (){
                                        deleteStudentData(storedoc[i]['id']);
                                      },
                                      icon: const Icon(Icons.delete,color: Colors.red,)
                                  )
                                ],
                              )
                          )
                        ]
                    ),
                  ]
                ],
              ),
            ),
          );
        }
    );

  }
}