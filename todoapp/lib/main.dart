import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:todoapp/common/show_model.dart';


void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ToDoApp',
        theme: ThemeData(),
        home: const HomePage(),
      ),
    )
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.grey.shade200,
    appBar: AppBar(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
      title: ListTile(
        leading: CircleAvatar(
        backgroundColor: Colors.amber.shade200,
        radius: 25,
        child: ClipOval(
          child: Image.asset(
            'assets/profile.png',
            fit: BoxFit.cover,
            width: 50,
            height: 50,
          ),
        ),
        ),

        title: Text('Hi, I\'m', 
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade400),),
        subtitle: const Text('Suhao',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
      ),

      actions: [
        Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(children: [
          IconButton(
            onPressed: () {}, 
            icon: const Icon(CupertinoIcons.calendar)),

          const SizedBox(width: 5),

          IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.bell))

        ],),)
      ],

    ),
    body: SingleChildScrollView(child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
        const Gap(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Text("To-Do Task List", 
                style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                        ),
                        ),
                Text("Wednesday, 6 November",
                style: TextStyle(
                        //fontWeight: FontWeight.bold,
                        color: Colors.black
                        ),
                        ),
            ],
            ),
          
          ElevatedButton(
          
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD5E8FA),
              foregroundColor: Colors.blue.shade900,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              )
            ),

            onPressed:() => showModalBottomSheet(

                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),

                context: context,
                builder: (context) => const AddNewTaskModel(),
                ),
            
            child: const Text('+ New Task'))
            ],
        ),
        
        const Gap(12),

        const Gap(30),

        Container(
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ), 
              width: 20,
            ), 
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(children: [
                  ListTile(
                    title: const Text('Learning Web Developer'),
                    subtitle: const Text('Learning ReactJs for FrontEnd'),
                    trailing: Transform.scale( 
                    scale: 1.3,
                    child: Checkbox(
                      
                      activeColor: Colors.blue.shade300,
                      shape: const CircleBorder(),
                      value: true, onChanged: (value) => print(value),),
                  )
                  )
                ]), 
              ),
            ),
          ]),
        ),

      ],
      ),
      ),
      )
    );
  }
}



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
