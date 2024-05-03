extends Node

const CONNECTION_IP = "192.168.8.188"
const CONNECTION_PORT = 1024
@onready var client = get_node("Client")
@onready var server = get_node("Server")

func _ready():
    server.connection_port = CONNECTION_PORT
    client.connection_ip = CONNECTION_IP
    client.connection_port = CONNECTION_PORT
    #demo: host server and print a message from server.
    server.host()
    server.rpc("message", "server says hello")

