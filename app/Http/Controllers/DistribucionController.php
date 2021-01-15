<?php

namespace sisVentas\Http\Controllers;

use Illuminate\Http\Request;

use sisVentas\Http\Requests;
use sisVentas\Distribucion;
use Illuminate\Support\Facades\Redirect;
use sisVentas\Http\Requests\DistribucionFormRequest;
use DB;
class DistribucionController extends Controller
{
      public function __construct()
    {
        $this->middleware('auth');
    }
    public function index(Request $request){
        if ($request) {
        	$query=trim($request->get('searchText'));
        	$distribucion=DB::table('Distribucion')->where('tipo_envio','LIKE','%'.$query.'%')
        	->where('estado','=','disponible')
        	->orderBy('id_distribucion','desc')
        	->paginate('7');
            return view('almacen.distribucion.index',["distribucion"=>$distribucion,"searchText"=>$query]);
        }

     }

     public function create(){

     	return view("almacen.distribucion.create");
     }

     public function store(DistribucionFormRequest $request){
        $distribucion=new Distribucion;
        $distribucion->tipo_envio=$request->get('tipo_envio');
        $distribucion->descripcion=$request->get('descripcion');
        $distribucion->estado='disponible';
      
        $distribucion->save();

        return Redirect::to('almacen/distribucion');

     }
     public function show($id)
    {
        return view("almacen.distribucion.show",["distribucion"=>Distribucion::findOrFail($id)]);
    }
    public function edit($id)
    {
        return view("almacen.distribucion.edit",["distribucion"=>Distribucion::findOrFail($id)]);
    }
    public function update(DistribucionFormRequest $request,$id)
    {
        $distribucion=Distribucion::findOrFail($id);
       $distribucion->tipo_envio=$request->get('tipo_envio');
        $distribucion->descripcion=$request->get('descripcion');
        $distribucion->update();
        return Redirect::to('almacen/distribucion');
    }
    public function destroy($id)
    {
        $distribucion=Distribucion::findOrFail($id);
        $distribucion->estado='no disponible';
        $distribucion->update();
        return Redirect::to('almacen/distribucion');
    }
}
