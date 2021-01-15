<?php

namespace sisVentas\Http\Controllers;

use Illuminate\Http\Request;

use sisVentas\Http\Requests;

use sisVentas\Producto;
use sisVentas\DetalleVenta;
use sisVentas\Venta;
use sisVentas\Persona;
use sisVentas\Distribucion;
use sisVentas\Transporte;

use Illuminate\Support\Facades\Input;
use Illuminate\Support\Facades\Redirect;
use Carbon\Carbon;
use sisVentas\Http\Requests\VentaFormRequest;
use DB;

class ShopingController extends Controller
{
       public function __construct()
    {

    }
    public function index(Request $request)
    {
        if ($request)
        {
            $query=trim($request->get('searchText'));
            $ventas=DB::table('Venta as v')
            ->join('persona as p','v.id_persona','=','p.id_persona')
            ->join('detalleventa as dv','v.id_venta','=','dv.id_venta')
            ->join('Distribucion as dis','v.id_distribucion','=','dis.id_distribucion')
            ->join('Transporte as trans','v.id_transporte','=','trans.id_transporte')
            ->select('v.id_venta','v.fecha_hora','p.nombre','v.tipo_comprobante','v.num_comprobante','dis.tipo_envio','trans.placa','v.impuesto','v.estado','v.total_venta')
            ->where('v.num_comprobante','LIKE','%'.$query.'%')
    
            ->orderBy('id_venta','desc')
            ->groupBy('v.id_venta','v.fecha_hora','p.nombre','v.tipo_comprobante','v.num_comprobante','dis.tipo_envio','trans.placa','v.impuesto','v.estado')
            ->paginate(7);
            return view('shoping.productolista.index',["ventas"=>$ventas,"searchText"=>$query]);
        }
    }
    //nos quedamos aqui listo para hacer el create
    public function create()
    {
        $personas=DB::table('Persona')->select('id_persona','nombre')->get();
        $productos= DB::table('Producto as pro')
          ->select(DB::raw('CONCAT(pro.id_producto," ",pro.nombre) as producto'),'pro.id_producto','pro.stock','pro.preciounidad','pro.nombre','pro.imagen') 
          ->where('pro.estado','=','disponoble')
          ->where('pro.stock','>','0')
          ->get();
          $distribuciones= DB::table('Distribucion as distri')
          ->select(DB::raw('CONCAT(distri.id_distribucion," ",distri.tipo_envio) as distribucion'),'distri.id_distribucion')
          ->where('distri.estado','=','disponible')
          ->get();
          $transportes= DB::table('Transporte as trans')
          ->select(DB::raw('CONCAT(trans.placa," ",trans.modelo) as transporte'),'trans.id_transporte')
          ->where('trans.estado','=','activo')
          ->get();
        return view("shoping.productolista.create",["personas"=>$personas,"productos"=>$productos,"distribuciones"=>$distribuciones,"transportes"=>$transportes]);
    }
    public function store (VentaFormRequest $request)
    {
         $var = DB::table('Venta')->max('num_comprobante');
          

      try{
        DB::beginTransaction();
        $venta= new Venta; 
        $venta->id_persona=$request->get('id_persona');
        $venta->id_distribucion=$request->get('id_distribucion');
        $venta->id_transporte=$request->get('id_transporte');
        $venta->tipo_comprobante=$request->get('tipo_comprobante');
        $venta->num_comprobante=$var+1;
        $venta->total_venta=$request->get('total_venta');

        $mytime= Carbon::now('America/Lima');
        $venta->fecha_hora=$mytime->toDateTimeString();
        $venta->impuesto='13';
        $venta->estado='Pendiente';
        $venta->save();
        // detalle_ingreso
        //todo estos son arreglos Array
         $id_producto= $request->get('id_producto');
         $cantidad= $request->get('pcantidad');
         $costo= $request->get('pcosto');
         //$descuento= $request->get('pdescuento');
        

          $cont=0;

          while ($cont<count($id_producto)) {
               $detalle= new Detalleventa;
               $detalle->id_venta=$venta->id_venta;
               $detalle->id_producto=$id_producto[$cont];
               $detalle->cantidad=$cantidad[$cont];
               $detalle->costo=$costo[$cont];
               $detalle->descuento=0;
               $detalle->save();
               $cont=$cont+1;
          }

          DB::commit();

      }catch(\exeption $e){

        DB::rollback();
      }
      return Redirect::to('shoping/productolista/create');

    }

    public function show($id)
    {
        $venta=DB::table('Venta as ven')
            ->join('persona as p','ven.id_persona','=','p.id_persona')
            ->join('detalleventa as dv','ven.id_venta','=','dv.id_venta')
             ->join('distribucion as dis','ven.id_distribucion','=','dis.id_distribucion')
             ->join('transporte as trans','ven.id_transporte','=','trans.id_transporte')
            ->select('ven.id_venta','ven.fecha_hora','p.nombre','ven.tipo_comprobante','ven.num_comprobante','ven.impuesto','dis.tipo_envio','trans.modelo','ven.estado','ven.total_venta')
            ->where('ven.id_venta','=',$id)
            ->first(); // firs saca el primero que cumpla

         $detalles=DB::table('detalleventa as dv')
         ->join('producto as pro','pro.id_producto','=','dv.id_producto')
         ->select('pro.nombre as producto','dv.cantidad','dv.descuento','dv.costo')
         ->where('dv.id_venta','=',$id)->get();
        return view("shoping.productolista.show",["venta"=>$venta,"detalles"=>$detalles]);
    }
    public function edit($id)
    {
       // return view("almacen.categoria.edit",["categoria"=>Categoria::findOrFail($id)]);
    }
   ///copia
    public function destroy($id)
    {
        $venta=Venta::findOrFail($id);
        $venta->estado='inactivo';
        $venta->update();
        return Redirect::to('ventas/venta');
    }
}
