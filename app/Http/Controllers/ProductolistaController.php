<?php

namespace sisVentas\Http\Controllers;

use Illuminate\Http\Request;

use sisVentas\Http\Requests;
use sisVentas\Producto;
use Illuminate\Support\Facades\Input;
use Illuminate\Support\Facades\Redirect;
use sisVentas\Http\Requests\ProductoFormRequest;
use DB;

class ProductolistaController extends Controller
{
     public function __construct()
    {
          
          }
    
    public function index(Request $request){
      if ($request) {
      	  $query= trim($request->get('searchText'));
      	  $productos=DB::table('Producto')->where('nombre','LIKE','%'.$query.'%')
      	  ->where('estado','=','disponoble')
      	  ->orderBy('id_producto','desc')
      	  ->paginate('7');
      	  return view('shoping.productolista.index',["productos"=>$productos,"searchText"=>$query]);
      }
}
}
