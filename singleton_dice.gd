extends Node


# DICE LOGIC FOR TRAVELING , without repeats between rolls
var travel_distance:int
var dice_current_values = [1,2,3,4,5,6]
var dice_next_values = [6,5,4,3,2,1]
var dice_index:int=5
func travel():
	dice_index +=1
	if dice_index >= dice_current_values.size():
		dice_current_values.shuffle()
		dice_next_values.shuffle()
		while dice_current_values[5]==dice_next_values[0]:
			print("travel dice_reshufle, next and previous value are the same")
			dice_next_values.shuffle()
		if dice_current_values[5]!=dice_next_values[0]:
			dice_next_values=dice_current_values
			print("travel dice_next_values ",dice_next_values)
		dice_index = 0
	travel_distance = dice_current_values[dice_index-1]
	print("travel dice_current_values ",dice_current_values)
	print("travel_distance ",travel_distance)
	return travel_distance
