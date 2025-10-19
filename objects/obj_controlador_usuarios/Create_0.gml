#region States

enum DataStates
{
	LOADING,
	CHOOSE,
	USERNAME,
	USER_TEST,
	WELCOME,
	ACCESS
}

state = DataStates.LOADING;

#endregion

#region HTTP

bin_id = "68f3c615ae596e708f1b1cc6";
access_key = "$2a$10$sZ9QTpUvKfE9JzXVWLIkIua2lY7p4Z8ZoXpW64w18Zn7GVa9hmgi6";
url = "https://api.jsonbin.io/v3/b/" + bin_id; 

var _headers = ds_map_create();
ds_map_add(_headers, "X-Access-Key", access_key);

request = http_request(url, "GET", _headers, ""); //guardar las ID mediante una solicitud HTTP

ds_map_destroy(_headers);

#endregion

#region Login

array = undefined;
username = "";
login = -1;
login_type = 0;

#endregion

actualizarPuntaje = function() {
	if (login >= 0) {
		array[login].score = score;
		
		var _headers = ds_map_create();
		ds_map_add(_headers, "Content-Type", "application/json");
		ds_map_add(_headers, "X-Access-Key", access_key);

		var _f = function(a, b){
			return b.score - a.score;
		}
		array_sort(array, _f);
		
		var _data = json_stringify(array);
		http_request(url, "PUT", _headers, _data);
		
		ds_map_destroy(_headers);
	}
};
