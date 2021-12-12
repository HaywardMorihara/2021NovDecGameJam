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
	"012": preload("res://game/objects/Bench.tscn"),
	"013": preload("res://game/objects/StreetSignPost.tscn"),
	"014": preload("res://game/objects/Chair.tscn"),
	"015": preload("res://game/objects/Present1.tscn"),
	"016": preload("res://game/objects/Present2.tscn"),
	"017": preload("res://game/objects/Present3.tscn"),
	"018": preload("res://game/objects/Present4.tscn"),
	"019": preload("res://game/objects/ChristmasLightsHorizontal.tscn"),
	"020": preload("res://game/objects/ChristmasLightsHorizontalLeftHalf.tscn"),
	"021": preload("res://game/objects/ChristmasLightsHorizontalRightHalf.tscn"),
	"022": preload("res://game/objects/ChristmasLightsVertical.tscn"),
	"023": preload("res://game/objects/ChristmasLightsVerticalTopHalf.tscn"),
	"024": preload("res://game/objects/ChristmasLightsVerticalBottomHalf.tscn"),
	"025": preload("res://game/objects/Wreath.tscn"),
	"026": preload("res://game/objects/Stocking.tscn"),
	"027": preload("res://game/objects/Rug.tscn"),
}

const HOUSES_FOR_PLACEMENT := {
	"h001": preload("res://game/houses/House.tscn"),	
	"h002": preload("res://game/houses/House2.tscn"),
}

var OBJECTS_FOR_PLACEMENT_KEYS := OBJECTS_FOR_PLACEMENT.keys()

var HOUSES_FOR_PLACEMENT_KEYS := HOUSES_FOR_PLACEMENT.keys()
