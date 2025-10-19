/// @desc Login

switch (state){
	case DataStates.CHOOSE: 
		/*if keyboard_check(vk_enter){
			login_type = (keyboard_lastkey == vk_enter) ? 0 : 1	
			
			keyboard_string = "";
			
			state = DataStates.USERNAME;
		}*/
		
		if (keyboard_check_pressed(vk_enter)) {
		    login_type = 0; // login
		    keyboard_string = "";
		    state = DataStates.USERNAME;
		}

		if (keyboard_check_pressed(vk_shift)) {
		    login_type = 1; // registro
		    keyboard_string = "";
		    state = DataStates.USERNAME;
		}
		
		break;
		
	case DataStates.USERNAME:
		username = keyboard_string;
	
		if keyboard_check_pressed(vk_enter){
			state = DataStates.USER_TEST;
		}
		break;
	
	case DataStates.USER_TEST:
		var _match = -1;
		var _len = array_length(array);
		for (var i = 0; i < _len; i++){
			var _user = array[i];
			if username == _user.username{
				_match = i;
			}
		}
	
		if (_match == -1){  //si no hubo coincidencias
			if (login_type == 1){
				var _headers = ds_map_create();
				ds_map_add (_headers, "Content-Type", "application/json");
				ds_map_add (_headers, "X-Access-Key", access_key);
			
				array_push(array ,{
					username: username,
					score: 0
				});
			
				var _f =function(a, b){
					return b.score - a.score;	
				}
			
				array_sort(array, _f);
			
				var _data = json_stringify(array);
			
				http_request(url, "PUT", _headers, _data);
			
				ds_map_destroy(_headers);
			
				state = DataStates.CHOOSE;
			}
		}
		else{
			if (login_type == 0){
				login = _match;
			
				global.username = username;       
				global.loginIndex = _match;       
				global.userArray = array;
			
			
				state = DataStates.WELCOME;
			}
			else{
				keyboard_string = "";	
			
				state = DataStates.USERNAME;
			}
		}
		break;
		
	case DataStates.WELCOME:
		if (keyboard_check_pressed(vk_enter)) {
			room_goto(rm_menu_principal);
		}
		break;
		
	case DataStates.ACCESS:
		if keyboard_check_pressed(vk_escape){
			room_goto(rm_menu_principal);
		}
		break;
}