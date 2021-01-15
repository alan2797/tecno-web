<?php

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It's a breeze. Simply tell Laravel the URIs it should respond to
| and give it the controller to call when that URI is requested.
|
*/

Route::get('/', function () {
    return view('welcome');
});

Route::resource('almacen/categoria','CategoriaController');

Route::resource('almacen/producto','ProductoController');
Route::resource('almacen/insumo','InsumoController');
Route::resource('almacen/distribucion','DistribucionController');
Route::resource('almacen/transporte','TransporteController');
Route::resource('usuario/cliente','ClienteController');
Route::resource('usuario/proveedor','ProveedorController');
Route::resource('compras/ingreso','IngresoController');
Route::resource('ventas/venta','VentaController');
Route::resource('produccion/producto','DetalleproductoController');
//shoping
Route::resource('shoping/productolista','ShopingController');
Route::resource('atender/atendido','ConfirmarVentaController');
Route::auth();

Route::get('/almacen/transporte','TransporteController@index');
