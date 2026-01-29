# Inventory.gd
class_name Inventory extends Node

signal inventory_updated # UI listens to this to redraw the grid
signal active_weapon_changed(new_weapon_data)

# Dependencies
@export var stats_controller: StatController
@export var weapon_manager: Node2D # Your "Hand" marker script

# Storage
@export var backpack: Array[ItemData] = []
var primary_weapon: WeaponResource
var secondary_weapon: WeaponResource

# State
var is_primary_active: bool = true

# --- ADD / REMOVE GENERIC ITEMS ---
func add_item(item: ItemData):
	backpack.append(item)
	inventory_updated.emit()
	stats_controller.add_modifiers_from_source(item, item.modifiers)

func remove_item(item: ItemData):
	if item in backpack:
		backpack.erase(item)
		inventory_updated.emit()
		stats_controller.remove_modifiers_from_source(item)

# --- WEAPON SLOT LOGIC ---

# Attempt to equip an item from the backpack into a specific slot
func equip_weapon(item: WeaponResource, is_primary_slot: bool):
	if item not in backpack:
		return # Can't equip what we don't have

	# 1. Determine which slot we are targeting
	var old_weapon = primary_weapon if is_primary_slot else secondary_weapon

	# 2. Unequip the old weapon (Move to backpack + Remove Stats)
	if old_weapon:
		_unequip_logic(old_weapon)
		backpack.append(old_weapon)

	# 3. Equip the new weapon (Remove from backpack + Add Stats)
	backpack.erase(item)
	
	if is_primary_slot:
		primary_weapon = item
	else:
		secondary_weapon = item
	
	_equip_logic(item)
	
	# 4. Refresh visuals if we modified the currently active slot
	if (is_primary_slot and is_primary_active) or (not is_primary_slot and not is_primary_active):
		_update_weapon_manager()
		
	inventory_updated.emit()

# --- SWAPPING LOGIC (The "Q" Key) ---
func swap_active_weapon():
	# Toggle the boolean
	is_primary_active = not is_primary_active
	_update_weapon_manager()

# --- INTERNAL HELPERS ---

func _update_weapon_manager():
	var active_data = primary_weapon if is_primary_active else secondary_weapon
	
	# Tell the WeaponManager (Hand) to spawn the scene
	# Note: We pass 'active_data' even if null (to clear hands)
	#weapon_manager.equip_weapon(active_data, stats_controller)
	
	active_weapon_changed.emit(active_data)

func _equip_logic(weapon: WeaponResource):
	# Apply Passive Stats (e.g. +5 Strength just for having it in the slot)
	if stats_controller and weapon.passive_modifiers:
		# Use the Resource itself as the Source Key
		stats_controller.add_modifiers_from_source(weapon, weapon.passive_modifiers)

func _unequip_logic(weapon: WeaponResource):
	# Remove Passive Stats
	if stats_controller:
		stats_controller.remove_modifiers_from_source(weapon)
