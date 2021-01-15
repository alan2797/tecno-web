@extends ('layouts.admin')
@section ('contenido')
	<div class="row">
		<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
			<h3>Nuevo Transaporte</h3>
			@if (count($errors)>0)
			<div class="alert alert-danger">
				<ul>
				@foreach ($errors->all() as $error)
					<li>{{$error}}</li>
				@endforeach
				</ul>
			</div>
			@endif

			{!!Form::open(array('url'=>'almacen/transporte','method'=>'POST','autocomplete'=>'off'))!!}
            {{Form::token()}}
            <div class="form-group">
            	<label for="placa">Placa</label>
            	<input type="text" name="placa" class="form-control" placeholder="placa...">
            </div>
            <div class="form-group">
            	<label for="Modelo">Modelo</label>
            	<input type="text" name="modelo" class="form-control" placeholder=modelo...">
            </div>
            <div class="form-group">
            	<label for="color">Color</label>
            	<input type="text" name="color" class="form-control" placeholder="color...">
            </div>
            <div class="form-group">
            	<label for="descripcion">Descripcion</label>
            	<input type="text" name="descripcion" class="form-control" placeholder="descripcion...">
            </div>
            <div class="form-group">
            	<button class="btn btn-primary" type="submit">Guardar</button>
            	<button class="btn btn-danger" type="reset">Cancelar</button>
            </div>

			{!!Form::close()!!}		
            
		</div>
	</div>
@endsection