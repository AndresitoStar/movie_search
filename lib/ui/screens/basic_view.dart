import 'package:flutter/material.dart';

abstract class BasicView extends StatelessWidget {
  const BasicView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Text('Basic View'),
            ),
            
          ),
        ],
      ),
    );
  }
  
}