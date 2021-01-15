<?php

namespace sisVentas\Http\Controllers;

use Illuminate\Http\Request;

use sisVentas\Http\Requests;
use sisVentas\Persona;
use Illuminate\Support\Facades\Redirect;
use sisVentas\Http\Requests\PersonaFormRequest;
use DB;
class ProveedorController extends Controller
{
    public function index(Request $request){
        if ($request) {
        	$query=trim($request->get('searchText'));
        	$clientes=DB::table('Persona')->where('nombre','LIKE','%'.$query.'%')
        	->where('tipopersona','=','proveedor')
        	->where('estado','=','activo')
        	->orderBy('id_persona','desc')
        	->paginate('7');
            return view('usuario.proveedor.index',["clientes"=>$clientes,"searchText"=>$query]);
        }

     }

     public function create(){

     	return view("usuario.proveedor.create");
     }

     public function store(PersonaFormRequest $request){
        $cliente=new Persona;
        $cliente->nombre=$request->get('nombre');
        $cliente->tipopersona='proveedor';
        $cliente->tipodocumento=$request->get('tipodocumento');
        $cliente->numero_documento=$request->get('numero_documento');
        $cliente->direccion=$request->get('direccion');
        $cliente->telefono=$request->get('telefono');
        $cliente->email=$request->get('email');
        $cliente->estado='activo';
      
        $cliente->save();

        return Redirect::to('usuario/proveedor');

     }
     public function show($id)
    {
        return view("usuario.proveedor.show",["cliente"=>Persona::findOrFail($id)]);
    }
    public function edit($id)
    {
        return view("usuario.proveedor.edit",["cliente"=>Persona::findOrFail($id)]);
    }
    public function update(PersonaFormRequest $request,$id)
    {
        $cliente=Persona::findOrFail($id);
       $cliente->nombre=$request->get('nombre');
        $cliente->tipodocumento=$request->get('tipodocumento');
        $cliente->numero_documento=$request->get('numero_documento');
        $cliente->direccion=$request->get('direccion');
        $cliente->telefono=$request->get('telefono');
        $cliente->email=$request->get('email');
        $cliente->update();
        return Redirect::to('usuario/proveedor');
    }
    public function destroy($id)
    {
        $cliente=Persona::findOrFail($id);
        $cliente->estado='inactivo';
        $cliente->update();
        return Redirect::to('usuario/proveedor');
    }
}
