extends Node


const OBJECTS_FOR_PLACEMENT := {
	"001": preload("res://game/objects/LampPost.tscn"),
	"002": preload("res://game/objects/Tree1.tscn"),
	"003": preload("res://game/objects/BigTree.tscn"),
	"004": preload("res://game/objects/SignPost.tscn"),
	"005": preload("res://game/objects/Snowman.tscn"),
	"006": preload("res://game/objects/Table.tscn"),
	"007": preload("res://game/objects/HotChocolate.tscn"),
	"008": preload("res://game/objects/CouchHorizontal.tscn"),
	"009": preload("res://game/objects/CouchVertical.tscn"),
	"010": preload("res://game/objects/FenceHorizontal.tscn"),
	"011": preload("res://game/objects/FenceVertical.tscn"),
}

const HOUSES_FOR_PLACEMENT := {
	"h001": preload("res://game/houses/House.tscn"),	
	"h002": preload("res://game/houses/House2.tscn"),
}

var OBJECTS_FOR_PLACEMENT_KEYS := OBJECTS_FOR_PLACEMENT.keys()

var HOUSES_FOR_PLACEMENT_KEYS := HOUSES_FOR_PLACEMENT.keys()
