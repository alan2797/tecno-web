<?php

namespace sisVentas;

use Illuminate\Database\Eloquent\Model;

class Persona extends Model
{
    protected $table='Persona';
     protected $primaryKey='id_persona';

     public $timestamps= false;

     protected $fallable=[
           'nombre',
           'tipopersona',
           'tipodocumento',
           'numero_documento',
           'direccion',
           'telefono',
           'email',
           'estado'
     ];
      protected $guarded=[
      
    ];
}
