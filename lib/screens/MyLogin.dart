import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome',
                style: Theme.of(context).textTheme.display1,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Username'
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Password'
                ),
                obscureText: true
              ),
              SizedBox(height: 24),
              RaisedButton(
                color: Colors.yellow,
                child: Text('ENTER'),
                onPressed: () => Navigator.pushReplacementNamed(context, '/catalog'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
