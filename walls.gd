extends StaticBody2D

signal left_edge_crossed
signal right_edge_crossed


func _on_left_edge_body_exited(_body: Node2D) -> void:
	left_edge_crossed.emit()


func _on_right_edge_body_exited(_body: Node2D) -> void:
	right_edge_crossed.emit()
