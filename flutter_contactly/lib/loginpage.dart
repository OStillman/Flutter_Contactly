import 'package:flutter/material.dart';
import 'helpers/constants.dart';

class LoginPage extends StatelessWidget {
  //Due to there being text for user input, this is needed to handle it
  final _pinCodeController = TextEditingController();

  @override //A build method is required to draw the UI canvas onto the page
  Widget build(BuildContext context){
    //This creates a circular frame for the logo
    final logo = CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: bigRadius,
      child: appLogo,
    );

    final pinCode = TextFormField(
      controller: _pinCodeController,
      keyboardType: TextInputType.phone,
      maxLength: 4,
      maxLines: 1,
      autofocus: true,
      decoration: InputDecoration(
        hintText: pinCodeHintText,
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
        hintStyle: TextStyle(
          color: Colors.white
        )
      ),
      style: TextStyle(
        color: Colors.white,
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(homePageTag);
        },
        padding: EdgeInsets.all(12),
        color: appGreyColor,
        child: Text(
          loginButtonText,
          style: TextStyle(color: Colors.white)
        ),
      ),
    );

    return Scaffold(
      backgroundColor: appDarkGreyColor,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: bigRadius),
            pinCode,
            SizedBox(height: buttonHeight),
            loginButton
          ],
        ),
      ),
    );
  }
}
