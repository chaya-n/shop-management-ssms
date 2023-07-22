import 'package:flutter/material.dart';

class CustomSnackBars {
  static const successSnackBar = SnackBar(
    content: Text('Successful'),
    backgroundColor: Colors.green,
  );
  static const failureSnackBar = SnackBar(
    content: Text('Fail'),
    backgroundColor: Colors.red,
  );
  static const zeroQuantitySnackbar = SnackBar(
    content: Text('Enter a quantity higher than ZERO'),
    backgroundColor: Colors.red,
  );
  static const failureLogInSnackBar = SnackBar(
    content: Text('Incorrect Username/Password'),
    backgroundColor: Colors.red,
  );
  static const failureSignInSnackBar = SnackBar(
    content: Text(
        'Enter the Details in correct format / The email Already exists / Password must be more than 6 Characters'),
    backgroundColor: Colors.red,
  );
}
