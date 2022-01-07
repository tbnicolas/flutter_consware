import 'package:flutter/material.dart';
import 'package:flutter_consware/data/shared_preference.dart';
import 'package:flutter_consware/domain/repository/db_repository.dart';
import 'package:flutter_consware/domain/response/product.dart';

enum DbStatus{
  NoRequestData,
  DataLoading,
  DataLoaded,
  DataError
}

class DataBaseController extends ChangeNotifier {

  String  _nombre = '';
  String _descripcion ='';
  int _valor =0;
  int _existencia =0;
  int _indiceActivo =0 ;

  final DbRepositoryInterface dbRepositoryInterface;
  final prefs =  UserPreference();

  DbStatus _dbStatus = DbStatus.NoRequestData;
  List<ProductResponseModel> _productResponseModel = [];

  DataBaseController({ required this.dbRepositoryInterface});
  

  List<ProductResponseModel> get productResponseModel => _productResponseModel;
  DbStatus  get dbStatus  => _dbStatus;
  String get nombre => _nombre;
  String get descripcion => _descripcion;
  int get valor => _valor;
  int get existencia => _existencia;
  int get indiceActivo => _indiceActivo;
 
 set indiceActivo( int indice ) {
    _indiceActivo = indice;
    notifyListeners();
  }

  set nombre( String nombre ) {
    _nombre = nombre;
    notifyListeners();
  }

set descripcion( String descripcion ) {
    _descripcion = descripcion;
    notifyListeners();

  }

  set valor( int valor ) {
    _valor = valor;
    notifyListeners();

  }

  set existencia( int existencia ) {
    _existencia = existencia;
    notifyListeners();

  }

  set productResponseModel( List<ProductResponseModel> productResponseModel ) {
    _productResponseModel = productResponseModel;
    notifyListeners();
  }

  set dbStatus( DbStatus dbStatus ) {
    _dbStatus = dbStatus;
    notifyListeners();
  }

  Future<void> handleFetchDataFromDatabase() async {
    try {
      _dbStatus = DbStatus.DataLoading;
      notifyListeners();

      final res =  await dbRepositoryInterface.listaRegistro(prefs.loginToken);
      productResponseModel = res;

      _dbStatus = DbStatus.DataLoaded;

      notifyListeners();


    } catch (e) {
      _dbStatus = DbStatus.DataError;

      notifyListeners();

    }
  }

Future<void> handleSaveInDatabase(ProductResponseModel product) async {
    try {
      
      _dbStatus = DbStatus.DataLoading;
      notifyListeners();
      await dbRepositoryInterface.nuevoRegistro(product);
      
      _dbStatus = DbStatus.DataLoaded;
      notifyListeners();
    } catch (e) {
      
      _dbStatus = DbStatus.DataError;
      notifyListeners();
    }
  } 

  Future<void> handleUpdateInDatabase(ProductResponseModel product) async {
    try {
      
      _dbStatus = DbStatus.DataLoading;
      notifyListeners();
      await dbRepositoryInterface.actualizarRegistro(product);
      
      _dbStatus = DbStatus.DataLoaded;
      notifyListeners();
    } catch (e) {
      
      _dbStatus = DbStatus.DataError;
      notifyListeners();
    }
  } 
}


