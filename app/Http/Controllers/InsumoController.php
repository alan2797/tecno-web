<?php

namespace sisVentas\Http\Controllers;

use Illuminate\Http\Request;

use sisVentas\Http\Requests;

use sisVentas\Insumo;
use Illuminate\Support\Facades\Input;
use Illuminate\Support\Facades\Redirect;
use Carbon\Carbon;
use sisVentas\Http\Requests\InsumoFormRequest;
use DB;

class InsumoController extends Controller
{
     public function __construct()
    {
        $this->middleware('auth');
    }
     public function index(Request $request){
        if ($request) {
        	$query=trim($request->get('searchText'));
        	$insumos=DB::table('Insumo')->where('nombre','LIKE','%'.$query.'%')
        	->where('estado','=','disponible')
        	->orderBy('id_insumo','desc')
        	->paginate('7');
            return view('almacen.insumo.index',["insumos"=>$insumos,"searchText"=>$query]);
        }

     }

     public function create(){

     	return view("almacen.insumo.create");
     }

     public function store(InsumoFormRequest $request){
        $insumo=new Insumo;
        $insumo->nombre=$request->get('nombre');
        $insumo->descripcion=$request->get('descripcion');
        $insumo->Stockkg=$request->get('Stockkg');
        $insumo->estado='disponible';
        if(Input::hasFile('imagen')){
            $file = Input::file('imagen');
            $file->move(public_path().'/imagenes/insumos/',$file->getClientOriginalName());
            $insumo->imagen=$file->getClientOriginalName();//aqui se devuelve el nombre de la imagen
        }
        $insumo->save();

        return Redirect::to('almacen/insumo');

     }
     public function show($id)
    {
        return view("almacen.insumo.show",["insumo"=>Insumo::findOrFail($id)]);
    }
    public function edit($id)
    {
        return view("almacen.insumo.edit",["insumo"=>Insumo::findOrFail($id)]);
    }
    public function update(InsumoFormRequest $request,$id)
    {
        $insumo=Insumo::findOrFail($id);
       $insumo->nombre=$request->get('nombre');
        $insumo->descripcion=$request->get('descripcion');
        $insumo->Stockkg=$request->get('Stockkg');
        if(Input::hasFile('imagen')){
            $file = Input::file('imagen');
            $file->move(public_path().'/imagenes/insumos/',$file->getClientOriginalName());
            $insumo->imagen=$file->getClientOriginalName();//aqui se devuelve el nombre de la imagen
        }
        $insumo->update();
        return Redirect::to('almacen/insumo');
    }
    public function destroy($id)
    {
        $insumo=Insumo::findOrFail($id);
        $insumo->estado='no disponible';
        $insumo->update();
        return Redirect::to('almacen/insumo');
    }

}
