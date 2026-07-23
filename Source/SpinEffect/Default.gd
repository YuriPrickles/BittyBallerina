extends SpinEffect
class_name Default

func spin_effect(plr:Player,dir:int):
	plr.rotate_level(90 * dir,true)
