<?php

namespace sisVentas;

use Illuminate\Database\Eloquent\Model;

class Producto extends Model
{
    protected $table='Producto';
    protected $primaryKey='id_producto';
    public $timestamps=false;

    protected $fillable=[
       'nombre',
       'stock',
       'preciounidad',
       'imagen'

    ];

    protected $guarded=[
    
    ];
}
