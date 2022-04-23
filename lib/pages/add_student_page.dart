import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddStudentPage extends StatefulWidget{
  @override
  _AddStudentPage createState()=>_AddStudentPage();
}

class _AddStudentPage extends State<AddStudentPage>{
  final _formKey= GlobalKey<FormState>();
  var name='';
  var email='';
  var password='';
  TextEditingController nameController= TextEditingController();
  TextEditingController emailController= TextEditingController();
  TextEditingController passwordController= TextEditingController();
  clearText(){
    nameController.clear();
    emailController.clear();
    passwordController.clear();
  }
  CollectionReference students=FirebaseFirestore.instance.collection('students');

  Future<void> addStudent(){
    return students
        .add({'name':name, 'email':email, 'password':password});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Student"),
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: _formKey,
            child: ListView(
              children: [
               TextFormField(
                    autofocus: true,
                    controller: nameController,
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
                  controller: emailController,
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
                 controller: passwordController,
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
                              name=nameController.text;
                              email=emailController.text;
                              password=passwordController.text;
                              addStudent();
                              clearText();
                              Navigator.pop(context);
                            }
                          },
                          child: const Text("Submit",
                          style: TextStyle(fontSize: 18),),
                        style: ElevatedButton.styleFrom(primary: Colors.blueAccent),
                      ),
                      ElevatedButton(
                          onPressed: ()=>clearText(),
                          child: const Text("Reset",
                            style: TextStyle(fontSize: 18),),
                      )
                    ],
                  ),
              ],
            )
        ),
      ),
    );
  }
}