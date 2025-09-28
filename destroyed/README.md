# Quicktweens

QuickTweens is my evergrowing collection of premade tweens that I put under a static class. All functions return a tween for chaining,
and can take an optional dictionary containing {'inital':[the tween you want to happen first]}

the current tweens are:

flip(node:Node,propertyname:NodePath,speed=.05,optional:Dictionary={})
    despite its name, it just tweens a single value from 1 to 0 and then back. you can add an optional for callback {'callback':[callable]} to execute when the
    tween is at zero. I used it to create a card flipping effect that changes the sprite when it's not visible to the player.

bounce(node:Node,propertyname:NodePath,bounceheight = 10.0,upspeed=.1,downspeed=.5,optional:Dictionary={})
    simply tweens a property to rise up a certain amount and then drop back down.

smooth_rise_and_fall(node:Node,propertyname:NodePath,rise_height:float=10,fall_height:float=150,speed=1,optional:Dictionary={})
    rises up a slight amount and then drops singificantly farther, similar to a death in a platformer game

knock_off_arc_2D(node:Node2D,rise_height:float=10,fall_height:float=150,arc_range:float=20,rotation_range:float=12,speed=1,optional:Dictionary={})
    adds an arc to the smooth rise and fall tween to add a tumbling offscreen effect.