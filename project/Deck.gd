extends Control

enum UnitOption {
	PRODUCER,
	SCOUT,
	DEFENDER,
	ATTACKER,
	HEAVY_ATTACKER,
	HEAVY_PRODUCER,
}

var unit_dict = {
	UnitOption.PRODUCER: "Producer",
	UnitOption.SCOUT: "Scout",
	UnitOption.DEFENDER: "Defender",
	UnitOption.ATTACKER: "Attacker",
	UnitOption.HEAVY_ATTACKER: "Heavy Attacker",
	UnitOption.HEAVY_PRODUCER: "Heavy Producer"
}


var defender_card_weight: float = 2
var attacker_card_weight: float = 2
var heavy_attacker_card_weight: float = 1
var heavy_producer_card_weight: float = 1
var scout_card_weight: float = 2
var producer_card_weight: float = 3

@export var draft_deck_card_count: int = 60

var draft_deck: Array = []
var player1_deck: Array = []
var player2_deck: Array = []

var player1_hand: Array = []
var player2_hand: Array = []

var player1_discard_deck: Array = []
var player2_discard_deck: Array = []

func _ready():
	create_draft_deck()
	shuffle_draft_deck()
	deal_draft_cards()
	print(player1_hand.map(unit_to_str))
	print(player2_hand.map(unit_to_str))
	

func unit_to_str(unit: UnitOption):
	return unit_dict[unit]


# function that creates a "draft_deck" of cards of length "draft_deck_card_count" based on card weights
# calculates how many of each card should be in the deck based on the card weights as weight / total_weight * draft_deck_card_count
func create_draft_deck():
	var total_weight = defender_card_weight + attacker_card_weight + heavy_attacker_card_weight + heavy_producer_card_weight + scout_card_weight + producer_card_weight
	var defender_card_count = roundi(defender_card_weight / total_weight * draft_deck_card_count)
	var attacker_card_count = roundi(attacker_card_weight / total_weight * draft_deck_card_count)
	var heavy_attacker_card_count = roundi(heavy_attacker_card_weight / total_weight * draft_deck_card_count)
	var heavy_producer_card_count = roundi(heavy_producer_card_weight / total_weight * draft_deck_card_count)
	var scout_card_count = roundi(scout_card_weight / total_weight * draft_deck_card_count)
	var producer_card_count = roundi(producer_card_weight / total_weight * draft_deck_card_count)

	for i in range(defender_card_count):
		draft_deck.append(UnitOption.DEFENDER)
	for i in range(attacker_card_count):
		draft_deck.append(UnitOption.ATTACKER)
	for i in range(heavy_attacker_card_count):
		draft_deck.append(UnitOption.HEAVY_ATTACKER)
	for i in range(heavy_producer_card_count):
		draft_deck.append(UnitOption.HEAVY_PRODUCER)
	for i in range(scout_card_count):
		draft_deck.append(UnitOption.SCOUT)
	for i in range(producer_card_count):
		draft_deck.append(UnitOption.PRODUCER)

# shuffle
func shuffle_draft_deck():
	for i in range(len(draft_deck)):
		var random_index = randi() % draft_deck_card_count
		var temp = draft_deck[i]
		draft_deck[i] = draft_deck[random_index]
		draft_deck[random_index] = temp

# dealt to players back and forth into each PlayerDeck, starting with player 1 
# until each has 5
func deal_draft_cards():
	for i in range(5):
		player1_hand.append(draft_deck.pop_back())
		player2_hand.append(draft_deck.pop_back())

# each player has a PlayerDiscardDeck

# Each card that is played by a player is removed from their deck and goes into their PlayerDiscardDeck
func play_card(player: int, card: UnitOption):
	if player == 1:
		player1_hand.erase(card)
		player1_discard_deck.append(card)
	else:
		player2_hand.erase(card)
		player2_discard_deck.append(card)

# Player 1 takes first action turn in placement phase

# Player 1 takes first action turn in action phase

# Each player discards all of their cards at the end of the action phase into
# their PlayerDiscardDeck

# Draft phase 
# Reveal the top 6 cards of DraftDeck face up.
# Player 2 goes first
# Take turns choosing from remaining cards until all cards are distributed.

# Each player shuffles their draft cards and their DiscardDeck into their PlayerDeck
# Each player draws 5 cards from their PlayerDeck.

# num of cards in deck.

# max num cards in hand: 5

# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
