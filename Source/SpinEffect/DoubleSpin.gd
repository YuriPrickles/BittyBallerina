extends SpinEffect
class_name DoubleSpin

func spin_effect(plr:Player,dir:int):
	plr.rotate_level(180 * dir,true)
	plr.reset_spin_effect()
