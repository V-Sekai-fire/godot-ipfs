extends Node2D
var user_dir = ProjectSettings.globalize_path("user://ipfs/repo")
var user_lock = "user://ipfs/repo.lock"
var res_ipfs_bin = "res://pack/windows/ipfs.exe"
var ipfs_bin = ProjectSettings.globalize_path("user://ipfs.exe")
var pid = -1


func _ready():	
	$HTTPRequest.connect("request_completed", Callable(self, "_on_request_completed"))
	$HTTPRequest2.connect("request_completed", Callable(self, "_on_request_completed"))
	$HTTPRequest3.connect("request_completed", Callable(self, "_on_request_completed"))
	_on_Button3_pressed()
	var dir = Directory.new()
	dir.open(ipfs_bin.get_base_dir())
	dir.copy(res_ipfs_bin, ipfs_bin)
	

func _exit_tree():
	OS.kill(pid)


func _on_Button_pressed():	
	var output = []
	OS.execute(ipfs_bin, ["cat", $TextEdit.text], output)
	$Label.text = str(output)	


func _on_Button2_pressed():
	OS.execute(ipfs_bin, ["shutdown"])
	get_tree().quit()


func _on_Button3_pressed():
	print(user_dir)
	OS.set_environment("IPFS_PATH", user_dir)		
		
	print(ipfs_bin)
	var output = []

	OS.create_process(ipfs_bin, ["daemon"])
	print(output)
	OS.execute(ipfs_bin, ["config", "profile", "apply", "server"])
	OS.execute(ipfs_bin, ["config", "Addresses.Gateway", "/ip4/127.0.0.1/tcp/11817"])
	OS.execute(ipfs_bin, ["config", "Addresses.API", "/ip4/127.0.0.1/tcp/11818"])
	OS.execute(ipfs_bin, ["daemon", "--enable-namesys-pubsub"])
	
	
func _on_HTTPRequest_request_completed(_result, _response_code, _headers, body):
	print(body.get_string_from_utf8())
