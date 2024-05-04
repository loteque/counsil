extends Control

var client
var server

func _on_connect_pressed():
    client.join()
    client.rpc("message", "client joined server: " + server.get_id)
func _on_host_pressed():
    server.host()