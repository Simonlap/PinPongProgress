import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Tischtennis Minispiele"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              // This container is just for demonstration and can contain other widgets
              alignment: Alignment.center,
              child: Text('Your content here'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 70.0, bottom: 10.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/registerpage');
                  },
                  child: Text('Register'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 70.0, bottom: 10.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/loginpage');
                  },
                  child: Text('Login'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  } 
}
