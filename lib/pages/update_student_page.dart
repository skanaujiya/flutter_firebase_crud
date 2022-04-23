import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UpadteStudentPage extends StatefulWidget{
  UpadteStudentPage({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  _UpdateStudentPage createState()=>_UpdateStudentPage();
}

class _UpdateStudentPage extends State<UpadteStudentPage>{
  final _formKey= GlobalKey<FormState>();
  CollectionReference students=FirebaseFirestore.instance.collection('students');
 Future<void> updateStudent(id,name,email,password){
   return students
       .doc(id)
       .update({'name':name,'email':email,'password':password});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Student Data"),
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Form(
            key: _formKey,
            child: FutureBuilder<DocumentSnapshot<Map<String,dynamic>>>(
              future: FirebaseFirestore.instance.collection('students').
              doc(widget.id).get(),
                builder: (BuildContext context,AsyncSnapshot<DocumentSnapshot> snapshot){
                  if (snapshot.hasError) {
                    return const Text("Something went wrong");
                  }
                  if(snapshot.connectionState==ConnectionState.waiting)
                    {
                      return const Center(
                        child: CircularProgressIndicator() ,
                      );
                    }

                  var data=snapshot.data!.data() as Map<String, dynamic>;
                  var name= data['name'];
                  var email= data['email'];
                  var password=data['password'];

                  return  ListView(
                    children: [
                      TextFormField(
                        initialValue: name,
                        onChanged: (value)=>{name=value},
                        decoration: const InputDecoration(
                            icon: Icon(FontAwesomeIcons.userGraduate),
                            labelText: "Name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8))
                            )
                        ),
                      ),
                      const SizedBox(height: 30,),
                      TextFormField(
                        initialValue:email,
                        onChanged: (value)=>{email=value},
                        decoration: const InputDecoration(
                            icon: Icon(FontAwesomeIcons.envelope),
                            labelText: "Email",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8))
                            )
                        ),
                        validator: (value){
                          if(value==null || value.isEmpty)
                          {
                            return 'Please Enter Email';
                          }else if(!value.contains('@')){
                            return 'Please Enter Valid Email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30,),
                      TextFormField(
                        initialValue: password,
                        onChanged: (value)=>{password=value},
                        obscureText: true,
                        decoration: const InputDecoration(
                            icon: Icon(FontAwesomeIcons.eyeSlash),
                            labelText: "Password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8))
                            )
                        ),
                      ),
                      const SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: (){
                              if(_formKey.currentState!.validate()){
                                updateStudent(widget.id,name,email,password);
                                Navigator.pop(context);
                              }
                            },
                            child: const Text("Update",
                              style: TextStyle(fontSize: 18),),
                            style: ElevatedButton.styleFrom(primary: Colors.blueAccent),
                          ),
                        ],
                      ),
                    ],
                  );
                }
            )
        ),
      ),
    );
  }
}