import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorAlert extends StatelessWidget {
  final String errorMssg;
  const ErrorAlert({super.key, required this.errorMssg});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Center(
          child: Image(
            image: AssetImage("assets/images/error.png"),
            width: 145.0,
          ),
        ),
        Center(
          child: Text(
            errorMssg,
            style:
                const TextStyle(color: Colors.red, fontWeight: FontWeight.w700),
          ),
        )
      ],
    );
  }
}
