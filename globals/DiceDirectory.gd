extends Node

@onready var dir :Dictionary = {
	"nature":{
		"fire":{
			"type":"nature",
			"icon":Global.glyph_list["nature"]["fire"],
			"name":"Fire",
			"description":"Does Firey Things",
			},
		"water":{
			"type":"nature",
			"icon":Global.glyph_list["nature"]["water"],
			"name":"Water",
			"description":"Does Watery Things",
			},
		"earth":{
			"type":"nature",
			"icon":Global.glyph_list["nature"]["earth"],
			"name":"Earth",
			"description":"Does earth Things",
			},
		"sky":{
			"type":"nature",
			"icon":Global.glyph_list["nature"]["sky"],
			"name":"Sky",
			"description":"Does sky-y Things",
			},
		"life":{
			"type":"nature",
			"icon":Global.glyph_list["nature"]["life"],
			"name":"Life",
			"description":"Does Lifey Things",
			},
		"":{
			"type":"none",
			"icon":Global.glyph_list["nature"][""],
			"name":"Blank",
			"description":"Does Nothing",
			},
		},
	"craft":{
		"lob":{
			"type":"craft",
			"icon":Global.glyph_list["craft"]["lob"],
			"name":"Lob",
			"description":"Huck Stuff",
		},
		"temper":{
			"type":"craft",
			"icon":Global.glyph_list["craft"]["temper"],
			"name":"Temper",
			"description":"Reinforce Stuff",
		},
		"":{
			"type":"craft",
			"icon":Global.glyph_list["craft"][""],
			"name":"Blank",
			"description":"Does Nothing",
		}
	},
	"arcane":{
		"echo":{
			"type":"arcane",
			"icon":Global.glyph_list["arcane"]["echo"],
			"name":"Echo",
			"description":"Repeat an effect",
		},
		"reflect":{
			"type":"arcane",
			"icon":Global.glyph_list["arcane"]["reflect"],
			"name":"Reflect",
			"description":"Huck Stuff",
		},
		"":{
			"type":"arcane",
			"icon":Global.glyph_list["arcane"][""],
			"name":"Blank",
			"description":"Does Nothing",
		},
	}
}
