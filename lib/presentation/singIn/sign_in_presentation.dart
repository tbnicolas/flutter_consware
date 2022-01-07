import 'package:flutter/material.dart';
import 'package:flutter_consware/domain/userCase/auth_case_controller.dart';
import 'package:flutter_consware/domain/userCase/db_case_controller.dart';
import 'package:flutter_consware/presentation/common/bottom_text.dart';
import 'package:flutter_consware/presentation/common/input.dart';
import 'package:flutter_consware/presentation/common/primary_burtton.dart';
import 'package:flutter_consware/presentation/common/text_screen.dart';
import 'package:flutter_consware/presentation/common/top_image.dart';
import 'package:flutter_consware/presentation/home/product.dart';
import 'package:flutter_consware/presentation/signUp/sign_up_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {

  static final routeName = 'signInScreen';

  const SignInScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    
    final auth = Provider.of<AuthCaseController>(context,listen: true);
    final db = Provider.of<DataBaseController>(context,listen: true);


    final size = MediaQuery.of(context).size;
    return Scaffold(

      body: ModalProgressHUD(
        inAsyncCall: (auth.authStatus == AuthStatus.Authenticating),
        progressIndicator: const CircularProgressIndicator(),
        child: SingleChildScrollView(
          child: Container(
            height: size.height,
            color: const Color(0xff201a32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              
              children: [
                const TopImage(
                  path: 'assets/login.svg',
                  margin: EdgeInsets.only(bottom: 60),
                ),
                TextScreen(
                  height: 90,
                  width: size.width,
                  h1Text: "LOGIN",
                  h2Text: "Please sign in to continue",
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
                  buttonText: 'Login',
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

                    await auth.handleSignIn();
                    
                    if ( auth.authStatus == AuthStatus.Authenticated ) {
                      db.handleFetchDataFromDatabase();
                       Navigator.pushNamed(context, ProductPage.routeName);
                    } else {
                      Fluttertoast.showToast(
                        msg: auth.error,
                        toastLength: Toast.LENGTH_LONG
                      );
                    }

                  },
                ),

                BottomText(
                  greyText: 'Don\'t have an account?',
                  tapText: ' Sign up',
                  margin: const EdgeInsets.only(top: 65),
                  onTap: (){
                    auth.clearFields();
                    Navigator.pushNamed(context, SignUpScreen.routeName);
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