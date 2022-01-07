import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_consware/domain/repository/db_repository.dart';
import 'package:flutter_consware/domain/response/product.dart';

class CrudFirebaseImpl extends DbRepositoryInterface{

  final FirebaseFirestore _db = FirebaseFirestore.instance;



  @override
  Future nuevoUsuario(String email, String uid) async {
     await _db.collection("users")
              .doc(uid)
              .set({
                "email": email,
                "uid": uid
              });
  }

  @override
  Future<List<ProductResponseModel>> listaRegistro(String uid) async {
       final resp = await _db.collection('users')
                          .doc(uid)
                          .collection("products")
                          .orderBy("fecha")
                          .get();
   
    final list = resp.docs.map((element) { 
      
        return   ProductResponseModel(
          nombre: element.get("nombre"),
          descripcion: element.get("descripcion") ,
          existencia: element.get("existencia"),
          valor:element.get("valor") ,
          uid: uid,
          update: element.id
        );
    }).toList();         

    //print(" ====> QuerySnapShot: $resp");

    return list;
  }

 @override
  Future nuevoRegistro(ProductResponseModel product) async{
    await _db.collection("users")
             .doc(product.uid)
             .collection("products")
             .doc()
             .set(product.toJson());
  }

  @override
  Future actualizarRegistro(ProductResponseModel product) async {
    final actualizar  = await _db.collection("users")
             .doc(product.uid)
             .collection("products")
             .doc(product.update)
             .update(product.toJson());

  }
}