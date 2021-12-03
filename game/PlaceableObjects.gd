extends Node


const OBJECTS_FOR_PLACEMENT := {
	"001": preload("res://game/objects/LampPost.tscn"),
	"002": preload("res://game/objects/Tree1.tscn"),
	"003": preload("res://game/objects/BigTree.tscn"),
	"004": preload("res://game/objects/SignPost.tscn"),
}

const HOUSES_FOR_PLACEMENT := {
	"h001": preload("res://game/houses/House.tscn"),	
}

var OBJECTS_FOR_PLACEMENT_KEYS := OBJECTS_FOR_PLACEMENT.keys()

var HOUSES_FOR_PLACEMENT_KEYS := HOUSES_FOR_PLACEMENT.keys()
