import 'package:flutter/material.dart';

class main_panel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black45,
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                child: Container(
                  color: Colors.black45,
                  height: 160,
                  width: 400,
                  child: Center(
                    child: Text('Cositas 1'),
                  ),
                ),
              ),
              SizedBox(width: 10,),
              Flexible(
                child: Container(
                  color: Colors.black45,
                  width: 400,
                  height: 160,
                  child: Center(
                    child: Text('Cositas 2'),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: Container(
                  height: 160,
                  width: 800,
                  color: Colors.black45,
                  child: Center(
                    child: Text('Custom Screen'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}