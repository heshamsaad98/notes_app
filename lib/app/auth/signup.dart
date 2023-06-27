import 'package:flutter/material.dart';
import 'package:noteapp/components/crud.dart';

import '../../components/customtextform.dart';
import '../../components/valid.dart';
import '../../constant/link_api.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  GlobalKey<FormState> formState = GlobalKey();
  final Crud _crud = Crud();

  bool isLoading = false;

  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  signUp() async {
    if(formState.currentState!.validate()){
      isLoading = true;
      setState(() {

      });
      var response = await _crud.postRequest(linkSignUp, {
        'username' : username.text,
        'email' : email.text,
        'password' : password.text,
      });
      isLoading = false;
      setState(() {

      });
      if(response['status'] == 'success'){
        Navigator.of(context).pushNamedAndRemoveUntil('success', (route) => false);
      }else{
        print('SignUp Fail');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading == true ? const Center(child: CircularProgressIndicator(),): Container(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Form(
              key: formState,
              child: Column(
                children: [
                  Image.asset("assets/images/logo.png", width: 200, height: 200,),
                  CustTextFormSign(
                    vaild: (val) => validInput(val!, 3, 20),
                    myController:  username,
                    hint: "username",
                  ),
                  CustTextFormSign(
                    vaild: (val) => validInput(val!, 5, 40),
                    myController:  email,
                    hint: "username",
                  ),
                  CustTextFormSign(
                    vaild: (val) => validInput(val!, 3, 10),
                    myController: password,
                    hint: "password",
                  ),
                  MaterialButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: 70.0, vertical: 10.0,
                    ),
                    onPressed: () async {
                      await signUp();
                    },
                    child: Text(
                      'SignUp',
                    ),
                  ),
                  Container(
                    height: 10.0,

                  ),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pushReplacementNamed('login');
                    },
                    child: Text(
                      'Login',
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
