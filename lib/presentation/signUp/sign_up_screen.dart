import 'package:flutter/material.dart';
import 'package:flutter_consware/domain/userCase/auth_case_controller.dart';
import 'package:flutter_consware/presentation/common/bottom_text.dart';
import 'package:flutter_consware/presentation/common/input.dart';
import 'package:flutter_consware/presentation/common/primary_burtton.dart';
import 'package:flutter_consware/presentation/common/text_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {

  static final routeName = 'signUpScreen';

  const SignUpScreen({Key? key}) : super(key: key);
 

  @override
  Widget build(BuildContext context) {
    
    final auth = Provider.of<AuthCaseController>(context,listen: true);
    final size = MediaQuery.of(context).size;
    return Scaffold(

      body: ModalProgressHUD(
        inAsyncCall: (auth.signUpStatus == SignUpStatus.Registering),
        progressIndicator: const CircularProgressIndicator(),
        child: SingleChildScrollView(
          child: Container(
            height: size.height,
            color: Color(0xff201a32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(left: 20,top: 50,bottom: 50),
                    width: size.width,
                    child: const Icon(
                      Icons.arrow_back,
                      color: Color(0xff6b6579),
                    ),
                  ),
                ),
                TextScreen(
                  height: 90,
                  width: size.width,
                  h1Text: "Create Account",
                  h2Text: "Please fill the input blow here",
                  margin: const EdgeInsets.only(bottom: 0, left: 20, right: 20),
                ),
                
                Input(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  labelText: 'Email',
                  icon: Icons.email,
                  color: Colors.blueAccent,
                  obscureText:false,
                  onChange: (String email){
                    auth.typedEmail = email;
                  },
                ),
                Input(
                  margin: const EdgeInsets.symmetric(vertical: 30,horizontal: 20),
                  labelText: 'Password',
                  icon: Icons.lock,
                  color: Colors.blueAccent,
                  obscureText:true,
                  onChange: (String password){
                    auth.typedPassword = password;
                  },
                ),

                PrimaryButton(
                  buttonText: 'Sing Up',
                  height: 60,
                  margin: const EdgeInsets.symmetric(horizontal: 75),
                  onTap: () async {
                    
                    if (!auth.emailValidator(auth.typedEmail)){
                      Fluttertoast.showToast(
                        msg: 'Email example: ex@example.com',
                        toastLength: Toast.LENGTH_LONG
                      );
                      return; 
                    }

                    if( !auth.passwordValidator(auth.typedPassword) ){

                        Fluttertoast.showToast(
                          msg: 'Password must be greater than 5 characters',
                          toastLength: Toast.LENGTH_LONG
                        );
                      return;
                    }
                    
                    await auth.handleSignUp();

                    if ( auth.signUpStatus == SignUpStatus.Registered ) {
                      //Navigator.pushNamed(context, HomePage.routeName);
                    } else {
                      Fluttertoast.showToast(
                        msg: auth.error,
                        toastLength: Toast.LENGTH_LONG
                      );
                    }

                  },
                ),

                BottomText(
                  greyText: 'Already have an account?',
                  tapText: ' Sign in',
                  margin: const EdgeInsets.only(top: 65),
                  onTap: (){
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      )
      
    );
  }
}