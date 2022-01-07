import 'package:flutter/material.dart';
import 'package:flutter_consware/domain/response/product.dart';
import 'package:flutter_consware/domain/userCase/auth_case_controller.dart';
import 'package:flutter_consware/domain/userCase/db_case_controller.dart';
import 'package:flutter_consware/presentation/common/bottom_text.dart';
import 'package:flutter_consware/presentation/common/input.dart';
import 'package:flutter_consware/presentation/common/primary_burtton.dart';
import 'package:flutter_consware/presentation/common/text_screen.dart';
import 'package:flutter_consware/presentation/home/product.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class UpdatePage extends StatelessWidget {

  static final routeName = 'updatePage';
  const UpdatePage({Key? key,}) : super(key: key);
 

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final db = Provider.of<DataBaseController>(context,listen: true);
    final auth = Provider.of<AuthCaseController>(context,listen: true);
    final index  = db.indiceActivo;

    return Scaffold(

      body: ModalProgressHUD(
        inAsyncCall: (db.dbStatus == DbStatus.DataLoading),
        progressIndicator: const CircularProgressIndicator(),
        child: SingleChildScrollView(
            child: Container(
              height: size.height,
              color: const Color(0xff201a32),
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
                    h1Text: "Update Product",
                    h2Text: "Please fill all the input blow here",
                    margin: const EdgeInsets.only(bottom: 0, left: 20, right: 20),
                  ),
                  
                  Input(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    labelText: 'Nombre',
                    /* controller: TextEditingController(
                      text: "${db.productResponseModel[index].nombre}"
                    ), */
                    icon: Icons.card_giftcard_sharp,
                    color: Colors.blueAccent,
                    obscureText:false,
                    onChange: (String nombre){
                      db.nombre = nombre;
                    },
                  ),
                  Input(
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                    labelText: 'Descripcion',
                    /* controller: TextEditingController(
                      text: "${db.productResponseModel[index].descripcion}"
                    ), */
                    icon: Icons.format_list_bulleted_rounded,
                    color: Colors.blueAccent,
                    obscureText:false,
                    onChange: (String descripcion){
                      db.descripcion = descripcion;
                    },
                  ),
                  Input(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    labelText: 'Valor',
                    /* controller: TextEditingController(
                      text: "${db.productResponseModel[index].valor}"
                    ), */
                    icon: Icons.money,
                    color: Colors.blueAccent,
                    obscureText:false,
                    onChange: (String valor){
                      db.valor = int.parse(valor);
                    },
                  ),
                  Input(
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                    labelText: 'Existencia',
                   /*  controller: TextEditingController(
                      text: "${db.productResponseModel[index].existencia}"
                    ), */
                    icon: Icons.add_comment_rounded,
                    color: Colors.blueAccent,
                    obscureText:false,
                    onChange: (String existencia){
                      db.existencia = int.parse(existencia);
                    },
                  ),
                 
      
                  PrimaryButton(
                    buttonText: 'Actualizar',
                    height: 60,
                    margin: const EdgeInsets.symmetric(horizontal: 75, vertical: 25),
                    onTap: () async {
                      await db.handleUpdateInDatabase(
                        ProductResponseModel(
                          nombre: db.nombre,
                          existencia: db.existencia,
                          valor: db.valor,
                          descripcion: db.descripcion,
                          uid: auth.userCredential.user!.uid,
                          update: db.productResponseModel[index].update
                        
                      ));

                      db.handleFetchDataFromDatabase();
                      Navigator.pushNamed(context, ProductPage.routeName);
                    }
                  ),
                ],
              ),
            ),
          ),
      ),
      
    );
  }
}