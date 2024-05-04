extends Control

var client
var server

func _on_connect_pressed():
    client.join()

func _on_host_pressed():
    server.host()
