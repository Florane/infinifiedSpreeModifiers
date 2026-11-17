if not BaseModifier then return end
ModifierCivilianPager = ModifierCivilianPager or class(BaseModifier)
ModifierCivilianPager._type = "ModifierCivilianPager"
ModifierCivilianPager.name_id = "none"
ModifierCivilianPager.desc_id = "menu_cs_modifier_civilian_pager"

function ModifierCivilianPager:trigger_pager(data)
    if data.unit:character_damage():dead() and managers.groupai:state():whisper_mode() then
        data.unit:unit_data().has_alarm_pager = true
        data.brain:begin_alarm_pager()
        return
    end
end
