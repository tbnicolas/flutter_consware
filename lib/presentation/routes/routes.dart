import 'package:flutter/material.dart';
import 'package:flutter_consware/presentation/create/create.dart';
import 'package:flutter_consware/presentation/home/product.dart';
import 'package:flutter_consware/presentation/signUp/sign_up_screen.dart';
import 'package:flutter_consware/presentation/singIn/sign_in_presentation.dart';
import 'package:flutter_consware/presentation/update/update.dart';

Map<String, WidgetBuilder> appRoutes = {

  SignInScreen.routeName: (BuildContext context) => const SignInScreen(),
  SignUpScreen.routeName: (BuildContext context) => const SignUpScreen(),
  ProductPage.routeName    : (BuildContext context) => ProductPage(),
  CreatePage.routeName: (BuildContext context) => const CreatePage(), 
  UpdatePage.routeName: (BuildContext context) =>  UpdatePage(), 
  
};