<?php

namespace sisVentas\Http\Requests;

use sisVentas\Http\Requests\Request;

class TransporteFormRequest extends Request
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
           'placa'=>'required|max:50',
           'modelo'=>'required|max:50',
           'color'=>'required',
           'descripcion',
           
        ];
    }
}
