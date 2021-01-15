@extends ('layouts.admin')
@section ('contenido')
	<div class="row">
		<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
			<h3>Nuevo Cliente</h3>
			@if (count($errors)>0)
			<div class="alert alert-danger">
				<ul>
				@foreach ($errors->all() as $error)
					<li>{{$error}}</li>
				@endforeach
				</ul>
			</div>
			@endif

			{!!Form::open(array('url'=>'usuario/cliente','method'=>'POST','autocomplete'=>'off'))!!}
            {{Form::token()}}
            <div class="form-group">
            	<label for="nombre">Nombre</label>
            	<input type="text" name="nombre" class="form-control" placeholder="nombre...">
            </div>
            <div class="form-group">
            	<label for="tipodocumento">Tipo de Documento</label>
            	<input type="text" name="tipodocumento" class="form-control" placeholder=tipodocumento...">
            </div>
            <div class="form-group">
            	<label for="Numero">Numero de Documento</label>
            	<input type="text" name="numero_documento" class="form-control" placeholder="numero...">
            </div>
            <div class="form-group">
            	<label for="Direccion">Direccion</label>
            	<input type="text" name="direccion" class="form-control" placeholder="direccion...">
            </div>
            <div class="form-group">
                  <label for="telefono">Telefono</label>
                  <input type="text" name="telefono" class="form-control" placeholder="telefono...">
            </div>
            <div class="form-group">
                  <label for="email">Email</label>
                  <input type="text" name="email" class="form-control" placeholder="Email...">
            </div>
            <div class="form-group">
            	<button class="btn btn-primary" type="submit">Guardar</button>
            	<button class="btn btn-danger" type="reset">Cancelar</button>
            </div>

			{!!Form::close()!!}		
            
		</div>
	</div>
@endsection