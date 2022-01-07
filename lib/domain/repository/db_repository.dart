import 'package:flutter_consware/domain/response/product.dart';

abstract class DbRepositoryInterface {

  //Future nuevoRegistro(LocationHistoryModel localHistory);

  Future< List<ProductResponseModel> > listaRegistro(String uid);
  
  Future nuevoUsuario(String email, String uid);

  Future nuevoRegistro(ProductResponseModel product);
  
  Future actualizarRegistro(ProductResponseModel product);

}