import 'package:flutter/material.dart';
import 'package:noteapp/components/crud.dart';
import 'package:noteapp/components/valid.dart';
import 'package:noteapp/constant/link_api.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:noteapp/main.dart';
import '../../components/customtextform.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  GlobalKey<FormState> formState = GlobalKey();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  final Crud _crud = Crud();
  bool isLoading = false;

  login() async {
    if(formState.currentState!.validate()){
      isLoading = true;
      setState(() {

      });
      var response = await _crud.postRequest(linkLogin, {
        'username' : email.text,
        'password' : password.text,
      });
      isLoading = false;
      setState(() {

      });
      if(response['status'] == 'success'){
        sharedPref.setString('id', response['data']['id'].toString());
        sharedPref.setString('username', response['data']['username']);
        //sharedPref.setString('email', response['data']['email']);
        Navigator.of(context).pushNamedAndRemoveUntil('test', (route) => false);
      }else{
        AwesomeDialog(
          context: context,
          title: 'تنبيه',
          body: Text('البريد الالكتروني أو كلمة المرور خطأأو الحساب غير موجود'),
        )..show();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading == true ? Center(child: CircularProgressIndicator(),) : Container(
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
                    myController:  email,
                    hint: "email",
                  ),
                  CustTextFormSign(
                    vaild: (val) => validInput(val!, 3, 20),
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
                      await login();
                    },
                    child: Text(
                      'Login',
                    ),
                  ),
                  Container(
                    height: 10.0,

                  ),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pushNamed('signup');
                    },
                    child: Text(
                      'Sign Up',
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
