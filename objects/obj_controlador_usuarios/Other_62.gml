// @desc Mostrar solicitud

if ds_map_find_value(async_load, "id") == request{
	
	if ds_map_find_value(async_load, "status") == 0 {
		var _r_str = ds_map_find_value(async_load, "result");
		var _result = json_parse(_r_str);
		array = _result.record;
		
		var _f = function(a, b){
			return b.score - a.score; // esto pone el puntaje más alto siempre en la parte de arriba
		}
		
		array_sort(array, _f);
		
		state = DataStates.CHOOSE;
	}
}


