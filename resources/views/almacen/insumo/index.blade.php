@extends ('layouts.admin')
@section ('contenido')
<div class="row">
	<div class="col-lg-8 col-md-8 col-sm-8 col-xs-12">
		<h3>Listado de Insumos Disponibles <a href="insumo/create"><button class="btn btn-success">Nuevo</button></a></h3>
		@include('almacen.insumo.search')
	</div>
</div>

<div class="row">
	<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
		<div class="table-responsive">
			<table class="table table-striped table-bordered table-condensed table-hover">
				<thead>
					<th>Id</th>
					<th>Nombre</th>
					<th>Descripcion</th>
					<th>Stock en KG</th>
					<th>Estado</th>
					<th>Imagen</th>
				</thead>
               @foreach ($insumos as $insu)
				<tr>
					<td>{{ $insu->id_insumo}}</td>
					<td>{{ $insu->nombre}}</td>
					<td>{{ $insu->descripcion}}</td>
					<td>{{ $insu->Stockkg}}</td>
					<td>{{ $insu->estado}}</td>
					
					<td>
						<img src="{{asset('imagenes/insumos/'.$insu->imagen)}}" alt="{{$insu->nombre}}" height="100px" width="100px" class="img-thumbnail">
					</td>
					<td>
						<!--metodo URL de laravelllama la accion alcontrolador de producto al metodo edit-->
						<a href="{{URL::action('InsumoController@edit',$insu->id_insumo)}}"><button class="btn btn-info">Editar</button></a>
                         <a href="" data-target="#modal-delete-{{$insu->id_insumo}}" data-toggle="modal"><button class="btn btn-danger">Eliminar</button></a>
					</td>
				</tr>
				@include('almacen.insumo.modal')
				@endforeach
			</table>
		</div>
		{{$insumos->render()}}
	</div>
</div>
@endsection