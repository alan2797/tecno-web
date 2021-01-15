<?php

namespace sisVentas;

use Illuminate\Database\Eloquent\Model;

class Insumo extends Model
{
     protected $table='Insumo';
     protected $primaryKey='id_insumo';

     public $timestamps= false;

     protected $fallable=[
           'nombre',
           'descripcion',
           'Stockkg',
           'estado',
           'imagen'
     ];
      protected $guarded=[
      
    ];
}
