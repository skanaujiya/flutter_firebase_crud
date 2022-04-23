import 'package:flutter/material.dart';
import 'pages/homePage.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final Future<FirebaseApp> _crud=Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _crud,
        builder: (context,snapshot){
        if(snapshot.hasError)
          {
            return const Text("Something went Wrong");
          }else if(snapshot.connectionState==ConnectionState.done)
            {
              return  MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: ThemeData(
                  primarySwatch: Colors.red,
                ),
                home: HomePage(),
              );
            }
        return const CircularProgressIndicator();
        },
    );
  }
}