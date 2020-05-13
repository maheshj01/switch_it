import 'package:flutter/material.dart';
import 'package:switch_it/switch_it.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Switch it'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool isEnabled1 = true;
  bool isEnabled2 = true;
  bool isEnabled3 = true;
  bool isEnabled4 = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SwitchIt(
                    isEnabled: isEnabled4,
                    backgroundColor: Colors.green,
                    inActiveColor: Colors.grey,
                    activeColor: Colors.yellow,
                    size: 40,
                  ),
                  SwitchIt(
                    isEnabled: isEnabled1,
                    size: 60,
                    activeColor: Colors.teal,
                    inActiveColor: Colors.grey,
                    backgroundColor: Colors.tealAccent,
                  ),
                  SwitchIt(
                    isEnabled: isEnabled3,
                    backgroundColor: Colors.red,
                    inActiveColor: Colors.grey,
                    activeColor: Colors.orange,
                    size: 80,
                    onChanged: (value) {
                      setState(() {
                        isEnabled3 = !isEnabled3;
                      });
                    },
                  ),
                  SwitchIt(
                    isEnabled: isEnabled2,
                    backgroundColor: Colors.black,
                    inActiveColor: Colors.blue,
                    size: 100,
                    activeColor: Colors.white,
                    color: Colors.white,
                    onChanged: (value) {
                      setState(() {
                        isEnabled2 = !isEnabled2;
                      });
                    },
                  ),
                  SwitchIt(
                    isEnabled: isEnabled1,
                    size: 140,
                    onChanged: (value) {
                      setState(() {
                        isEnabled1 = !isEnabled1;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                padding: EdgeInsets.only(right: 80),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Size: 40',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Size: 60',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Size: 80',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Size: 100',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Size: 140',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
