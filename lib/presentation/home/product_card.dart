import 'package:flutter/material.dart';
import 'package:flutter_consware/domain/userCase/db_case_controller.dart';
import 'package:flutter_consware/presentation/common/modal.dart';
import 'package:flutter_consware/presentation/update/update.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {

  final int index;
  final EdgeInsetsGeometry? margin;

  ProductCard({required this.index, this.margin});

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<DataBaseController>(context,listen: true);
    
    final size = MediaQuery.of(context).size;


    return Container(
      height: 100,
      width: size.width,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color:  const Color(0xff392f4e)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
           CircleAvatar(
                radius: 30,
                child: Text("# ${index + 1}"),
              ),
           Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             
               Container(
                width: 200,
                //color: Colors.amber,
                child: Text(
                  products.productResponseModel[index].nombre ?? '',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700
                  ),
                ),
              ),
              Container(
                width: 200,
                //color: Colors.red,
                child: Text(
                  "Valor: ${ products.productResponseModel[index].valor}",
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                ),
              ),

              Container(
                width: 200,
                //color: Colors.red,
                child: Text(
                  "Existencia: ${ products.productResponseModel[index].existencia}",
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                ),
              ),
               GestureDetector(
                onTap: () {
                  products.indiceActivo = index;
                  Navigator.pushNamed(context, UpdatePage.routeName);
                },
                child: Container(
                  margin: EdgeInsets.only(top:5),
                  alignment: Alignment.center,
                  height: 20,
                  width: 200,
                  decoration: BoxDecoration(
                     color: Colors.green,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Text("Actualizar",style: TextStyle(
                    color: Colors.white
                  ),),

                ),
              )

              
            ],
          ),
           GestureDetector(
              onTap: (){
                if( products.productResponseModel[index].descripcion != '' ){

                  final Modal modal =  Modal();
                  modal.mainBottomSheet(context, products.productResponseModel[index].descripcion!);

                } else {
                  Fluttertoast.showToast(msg: 'No Description',toastLength: Toast.LENGTH_LONG);
                }
              },
              child: const Icon(
                Icons.chevron_right,
                color: Colors.white,
                size: 24
              ),
            ),
          
        ],
      ),
    );
  }
}