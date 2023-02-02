import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mynote_sflite/custom_model.dart';
import 'package:mynote_sflite/database_helper.dart';

class MynotePage extends StatefulWidget {
  MynotePage({super.key});

  @override
  State<MynotePage> createState() => _MynotePageState();
}

class _MynotePageState extends State<MynotePage> {
  TextEditingController titleController = TextEditingController();

  TextEditingController descrController = TextEditingController();

  Random random = Random();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Get Storage"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: titleController,
                decoration: InputDecoration(hintText: "First Name"),
              ),
              TextField(
                controller: descrController,
                decoration: InputDecoration(hintText: "Last Name"),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final todo = Todo(
                          id: random.nextInt(100),
                          title: titleController.text,
                          description: descrController.text);
                      await DatabaseHelper.instance.createTodo(todo);
                    },
                    child: Text("Add"),
                  ),
                  ElevatedButton(
                    onPressed: () async {},
                    child: Text("Update"),
                  ),
                ],
              ),
              Container(
                height: 400,
                width: screenWidth,
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    int serial = index + 1;
                    return ListTile(
                      leading: Text(serial.toString()),
                      title: Text("First Name"),
                      subtitle: Text("Last Name"),
                    );
                  },
                ),
              ),

              // Container(
              //   height: 400,
              //   child: FutureBuilder(
              //     future: DatabaseHelper.instance.getCustomer(),
              //     builder: (BuildContext context, AsyncSnapshot<List<CustomerModel>> snapshot){

              //       if(!snapshot.hasData) {
              //         return Text("Loading......");
              //       }
              //       return ListView(
              //         children: snapshot.data!.map((customer) {
              //           return ListTile(
              //             trailing: Row(
              //               mainAxisSize: MainAxisSize.min,
              //               children: [
              //                 IconButton(
              //                   onPressed: ()async{

              //                   },
              //                   icon: Icon(Icons.delete, color: Colors.red,)
              //                 ),
              //                 IconButton(
              //                   onPressed: (){
              //                     setState(() {

              //                     });

              //                   },
              //                   icon: Icon(Icons.edit)
              //                 )
              //               ],
              //             ),
              //             title: Text("${customer.firstName}" + "${customer.lastName}"),
              //             subtitle: Text("${customer.email}"),
              //           );
              //         }).toList(),
              //       );
              //     }
              //   )
              // )
            ],
          ),
        ),
      ),
    );
  }
}
