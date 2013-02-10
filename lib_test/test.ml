open Lwt

let req = "<?xml version=\"1.0\"?><methodCall><methodName>session.login_with_password</methodName><params><param><value><string>root</string></value></param><param><value><string>xenroot</string></value></param></params></methodCall>"

module Client=Client.ClientF(Lwt)

let testrpc x = 
	Rpc_client_js.do_json_rpc_opt ~url:"http://st11.uk.xensource.com/jsonrpc" x

let _ =
	Client.Session.login_with_password testrpc "root" "xenroot" "1.0" >>= fun x ->
	Client.Event.from testrpc x ["*"] "" 1.0 >>= fun res ->
	let events = Event_types.event_from_of_rpc res in
	Firebug.console##log (Js.string (Printf.sprintf "Length=%d" (List.length events.Event_types.events)));
(*	List.iter (fun (vm_ref,vm_rec) ->
		Firebug.console##log (Js.string (Printf.sprintf "Name: %s" vm_rec.API.vM_name_label))) l;*)
	Lwt.return ()

