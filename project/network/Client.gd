extends Node

var connection_ip
var connection_port

func join():
    var id = _connect_to_server()
    await get_tree().create_timer(1).timeout
    rpc("message", "client joined: " + str(id))

func _connect_to_server():
    var peer = ENetMultiplayerPeer.new()
    peer.create_client(connection_ip, connection_port)
    get_tree().set_multiplayer(SceneMultiplayer.new(), self.get_path())
    multiplayer.multiplayer_peer = peer
    return multiplayer.get_unique_id()

@rpc("any_peer", "call_local")
func message(message_data):
    print(str("-> ", message_data, "\n"))