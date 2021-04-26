extends Node2D
var user_dir = "user://ipfs"
var ipfs_bin = ProjectSettings.globalize_path("res://pack/linux/ipfs")

func _exit_tree():
	_on_Button2_pressed()
	
func _on_request_completed(_result, _response_code, _headers, body):
	print(body.get_string_from_utf8())

func _ready():	
	$HTTPRequest.connect("request_completed", Callable(self, "_on_request_completed"))

func _on_Button_pressed():
	$HTTPRequest.request("http://127.0.0.1:11815/api/v0/cat?arg=/ipfs/QmW7S5HRLkP4XtPNyT1vQSjP3eRdtZaVtF6FAPvUfduMjA")


func _on_Button2_pressed():
	$HTTPRequest.request("http://127.0.0.1:11816/api/v0/shutdown", [], true, HTTPClient.METHOD_POST)


func _on_Button3_pressed():
	user_dir = ProjectSettings.globalize_path(user_dir)
	print(user_dir)
	OS.set_environment("IPFS_PATH", user_dir)
	var dir = Directory.new()
	var output = []
	if dir.open(user_dir) == OK:
		dir.remove("api")
	else:
		OS.create_process(ipfs_bin, ["init", "--profile", "server"])
		
	print(ipfs_bin)
	print(output)
#	limit interference
	OS.create_process(ipfs_bin, ["config", "--json", "Addresses.Swarm", "[\"/ip4/0.0.0.0/tcp/11814\",\"/ip6/::/tcp/11814\",\"/ip4/0.0.0.0/udp/11814/quic\",\"/ip6/::/udp/11814/quic\"]"])
	print(output)
	
	OS.create_process(ipfs_bin, ["config", "Addresses.Gateway", "/ip4/127.0.0.1/tcp/11815"])
	print(output)
	OS.create_process(ipfs_bin, ["config", "Addresses.API", "/ip4/127.0.0.1/tcp/11816"])
#
	print(output)
	OS.create_process(ipfs_bin, ["daemon", "--enable-namesys-pubsub"])
	print(output)
