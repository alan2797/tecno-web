<?php

namespace sisVentas;

use Illuminate\Database\Eloquent\Model;

class Produccion extends Model
{
    protected $table='Produccion';
     protected $primaryKey='id_produccion';

     public $timestamps= false;

     protected $fallable=[
           'fecha_produccion',
           'cantidad',
           'id_persona',
           'id_producto'
          
           
     ];
      protected $guarded=[
      
    ];
}
