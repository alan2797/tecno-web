<?php

namespace sisVentas\Http\Controllers;

use Illuminate\Http\Request;

use sisVentas\Http\Requests;
use sisVentas\Transporte;
use Illuminate\Support\Facades\Redirect;
use sisVentas\Http\Requests\TransporteFormRequest;
use DB;

class TransporteController extends Controller

{
      public function __construct()
    {
        $this->middleware('auth');
    }
    public function index(Request $request){
        if ($request) {
        	$query=trim($request->get('searchText'));
        	$transportes=DB::table('Transporte')->where('placa','LIKE','%'.$query.'%')
        	->where('estado','=','activo')
        	->orderBy('id_transporte','desc')
        	->paginate('7');
            return view('almacen.transporte.index',["transportes"=>$transportes,"searchText"=>$query]);
        }

     }

     public function create(){

     	return view("almacen.transporte.create");
     }

     public function store(TransporteFormRequest $request){
        $transporte=new Transporte;
        $transporte->placa=$request->get('placa');
        $transporte->modelo=$request->get('modelo');
        $transporte->color=$request->get('color');
        $transporte->descripcion=$request->get('descripcion');
        $transporte->estado='activo';
      
        $transporte->save();

        return Redirect::to('almacen/transporte');

     }
     public function show($id)
    {
        return view("almacen.transporte.show",["transporte"=>Transporte::findOrFail($id)]);
    }
    public function edit($id)
    {
        return view("almacen.transporte.edit",["transporte"=>Transporte::findOrFail($id)]);
    }
    public function update(TransporteFormRequest $request,$id)
    {
        $transporte=Transporte::findOrFail($id);
        $transporte->placa=$request->get('placa');
        $transporte->modelo=$request->get('modelo');
        $transporte->color=$request->get('color');
        $transporte->descripcion=$request->get('descripcion');
        $transporte->update();
        return Redirect::to('almacen/transporte');
    }
    public function destroy($id)
    {
        $transporte=Transporte::findOrFail($id);
        $transporte->estado='inactivo';
        $transporte->update();
        return Redirect::to('almacen/transporte');
    }
}
