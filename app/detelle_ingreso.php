<?php

namespace sisVentas;

use Illuminate\Database\Eloquent\Model;

class detelle_ingreso extends Model
{
    protected $table='Detalle_ingreso';

    protected $primaryKey='id_detalle';

    public $timestamps=false;


    protected $fillable =[
    	'precio_compra',
        'cantidad',
    	'id_insumo',
    	'id_ingreso'
    ];

    protected $guarded =[

    ];
}
