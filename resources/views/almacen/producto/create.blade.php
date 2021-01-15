@extends ('layouts.admin')
@section ('contenido')
	<div class="row">
		<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
			<h3>Nueva Producto</h3>
			@if (count($errors)>0)
			<div class="alert alert-danger">
				<ul>
				@foreach ($errors->all() as $error)
					<li>{{$error}}</li>
				@endforeach
				</ul>
			</div>
			@endif

			{!!Form::open(array('url'=>'almacen/producto','method'=>'POST','autocomplete'=>'off','files'=>'true'))!!}
            {{Form::token()}}
            <div class="form-group">
            	<label for="nombre">Nombre</label>
            	<input type="text" name="nombre" class="form-control"  placeholder="Nombre...">
            </div>
            <div class="form-group">
            	<label for="Stock">Stock</label>
            	<input type="text" name="stock" class="form-control"  placeholder="stock...">
            </div>
             <div class="form-group">
            	<label for="preciounidad">Precio Unidad</label>
            	<input type="text" name="preciounidad" class="form-control" placeholder="precio unitario...">
            </div>
             <div class="form-group">
                  <label for="imagen">imagen</label>
                  <input type="file" name="imagen" class="form-control">
            </div>
            <div class="form-group">
            	<button class="btn btn-primary" type="submit">Guardar</button>
            	<button class="btn btn-danger" type="reset">Cancelar</button>
            </div>


			{!!Form::close()!!}		
            
		</div>
	</div>
@endsection