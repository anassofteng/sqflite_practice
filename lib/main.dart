import 'package:flutter/material.dart';
import 'crud.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const sqflite(),
    );
  }
}

class sqflite extends StatefulWidget {
  const sqflite({super.key});

  @override
  State<sqflite> createState() => _sqfliteState();
}

class _sqfliteState extends State<sqflite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sqflite tutorial'),
        backgroundColor: Colors.red,
        shadowColor: Colors.amber.shade100,
      ),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            ElevatedButton(
                onPressed: () async {
                  await crud.instance.insert({crud.columnName: "anas arshad"});
                },
                child: const Text('insert')),
            ElevatedButton(
                onPressed: () async {
                  var dbquerry = await crud.instance.queryDatabase();
                  print(dbquerry);
                },
                child: const Text('Read')),
            ElevatedButton(
                onPressed: () async {
                  await crud.instance.update({
                    crud.columnId: 2,
                    crud.columnName: "Hamza Arshad",
                  });
                },
                child: const Text('Update')),
            ElevatedButton(
                onPressed: () async {
                  await crud.instance.delete(2);
                },
                child: const Text('Delete')),
          ])),
    );
  }
}
