import 'package:flutter/material.dart';
import 'package:flutter_consware/domain/userCase/auth_case_controller.dart';
import 'package:flutter_consware/domain/userCase/db_case_controller.dart';
import 'package:flutter_consware/presentation/common/input.dart';
import 'package:flutter_consware/presentation/common/text_screen.dart';
import 'package:flutter_consware/presentation/create/create.dart';
import 'package:flutter_consware/presentation/home/product_card.dart';
import 'package:flutter_consware/presentation/singIn/sign_in_presentation.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatelessWidget {
  static final routeName = 'home';

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthCaseController>(context,listen: true);
    final db = Provider.of<DataBaseController>(context,listen: true);

    final size = MediaQuery.of(context).size;

    return Scaffold(
       
      body: ModalProgressHUD(
        inAsyncCall: (db.dbStatus == DbStatus.DataLoading),
        progressIndicator: const CircularProgressIndicator(),
        child: Container(
          color: const Color(0xff201a32),
          child: ListView.builder(
            itemCount: db.productResponseModel.length + 1 ,
            itemBuilder: (context, index) {
              if( index == 0 ) {
                return Container(
                  height: 20,
                );
              } else {

              return ProductCard(
                    index: index - 1,
                    margin: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 20
                    ),
                  ); 
              }    
            },
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [

       

           FloatingActionButton(
            heroTag: UniqueKey(),
            child:  Container(
              child: const Icon(Icons.add),
            ),
            onPressed: () async{
              Navigator.pushNamed(context, CreatePage.routeName);
              
            }
          ),
           const SizedBox(
            height: 30,
          ),

           FloatingActionButton(
            heroTag: UniqueKey(),
            child:  Container(
              child: const Icon(Icons.exit_to_app),
            ),
            onPressed: () async{
              await auth.handleSingOut();

              Navigator.popAndPushNamed(context, SignInScreen.routeName);
            }
          ),
         
          
        ],
      ),
    );
  }
}