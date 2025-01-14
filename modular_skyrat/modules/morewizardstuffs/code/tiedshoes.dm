/obj/effect/proc_holder/spell/pointed/knotlaces
	name = "Tie shoelaces"
	desc = "Literally just tie the shoelaces of a target together"
	school = "transmutation"
	action_icon_state = "barn"
	charge_max = 100
	cooldown_min = 35
	invocation = "TAN'GEL"
	invocation_type = INVOCATION_WHISPER
	var/static/list/compatible_mobs_typecache = typecacheof(list(/mob/living/carbon/human))

/obj/effect/proc_holder/spell/pointed/knotlaces/cast(list/targets, mob/user)
	if(!targets.len)
		to_chat(user, span_warning("No target found in range!"))
		return FALSE
	if(!can_target(targets[1], user))
		return FALSE

	var/mob/living/carbon/target = targets[1]
	if(target.can_block_magic(MAGIC_RESISTANCE))
		to_chat(user, span_warning("The spell had no effect!"))
		return FALSE
	var/obj/item/clothing/shoes/tiedshoes = target.shoes
	if (!tiedshoes?.can_be_tied)
		to_chat(user, span_warning("[target] does not have knottable shoes!"))
		return
	tiedshoes.adjust_laces(SHOES_KNOTTED)

/obj/effect/proc_holder/spell/pointed/knotlaces/can_target(atom/target, mob/user, silent)
	. = ..()
	if(!.)
		return FALSE
	if(!is_type_in_typecache(target, compatible_mobs_typecache))
		if(!silent)
			to_chat(user, span_warning("You are unable to curse [target]!"))
		return FALSE
	return TRUE
