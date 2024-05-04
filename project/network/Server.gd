extends Node

var connection_port

func host():
    var id = _launch_server()
    rpc("message", "server: " + str(id))

func _launch_server():
    var peer = ENetMultiplayerPeer.new()
    peer.create_server(connection_port)
    get_tree().set_multiplayer(SceneMultiplayer.new(), self.get_path())
    multiplayer.multiplayer_peer = peer
    

@rpc("any_peer", "call_local")
func message(message_data):
    print(str("-> ", message_data, "\n"))

@rpc("authority", "call_local")
func get_id():
    return multiplayer.get_unique_id()