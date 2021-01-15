<?php

namespace sisVentas\Http\Controllers;

use Illuminate\Http\Request;

use sisVentas\Http\Requests;

use sisVentas\Producto;
use Illuminate\Support\Facades\Input;
use Illuminate\Support\Facades\Redirect;
use sisVentas\Http\Requests\ProductoFormRequest;
use DB;
class ProductoController extends Controller
{
     public function __construct()
    {
        $this->middleware('auth');
    }
    
    public function index(Request $request){
      if ($request) {
      	  $query= trim($request->get('searchText'));
      	  $productos=DB::table('Producto')->where('nombre','LIKE','%'.$query.'%')
      	  ->where('estado','=','disponoble')
      	  ->orderBy('id_producto','desc')
      	  ->paginate('7');
      	  return view('almacen.producto.index',["productos"=>$productos,"searchText"=>$query]);
      }

    }

    public function create(){
    	return view("almacen.producto.create");
    }

     public function store(ProductoFormRequest $request){
     	$producto= new Producto;
     	$producto->nombre=$request->get('nombre');
        $producto->stock=$request->get('stock');
        $producto->preciounidad=$request->get('preciounidad');
        $producto->estado='disponoble';
         if(Input::hasFile('imagen')){
            $file = Input::file('imagen');
            $file->move(public_path().'/imagenes/productos/',$file->getClientOriginalName());
            $producto->imagen=$file->getClientOriginalName();//aqui se devuelve el nombre de la imagen
        }
        $producto->save();

        return Redirect::to('almacen/producto');


     }
     public function show($id){
     	return view("almacen.producto.show",["producto"=>Producto::findOrFail($id)]);

     }
     public function edit($id){
     	return view("almacen.producto.edit",["producto"=>Producto::findOrFail($id)]);

     }
     public function update(ProductoFormRequest $request,$id){
     	$producto=Producto::findOrFail($id);
        $producto->nombre=$request->get('nombre');
        $producto->stock=$request->get('stock');
        $producto->preciounidad=$request->get('preciounidad');
          if(Input::hasFile('imagen')){
            $file = Input::file('imagen');
            $file->move(public_path().'/imagenes/productos/',$file->getClientOriginalName());
            $producto->imagen=$file->getClientOriginalName();//aqui se devuelve el nombre de la imagen
        }

        $producto->update();
        return Redirect::to('almacen/producto');

     }
     public function destroy($id){
     	$producto=Producto::findOrFail($id);
     	$producto->estado='agotado';
     	$producto->update();
     	 return Redirect::to('almacen/producto');

     }

}
