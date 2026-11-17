blt.vm.dofile(ModPath .. "modifiercivilianpager.lua")

--always assume repeating modifiers
local __modifiers_to_select = CrimeSpreeManager.modifiers_to_select
function CrimeSpreeManager:modifiers_to_select(table_name,_,...)
    return __modifiers_to_select(self,table_name,true,...)
end

table.insert(tweak_data.crime_spree.modifiers.stealth,{
	id = "civilian_pager",
	icon = "crime_spree_civs_killed",
	class = "ModifierCivilianPager",
	prerequisite = "civs_3",
	data = {}
})
tweak_data.crime_spree.repeating_modifiers["loud"] = {
	{
		id = "medic_heal_rpt_",
		icon = "crime_spree_medic_speed",
		class = "ModifierHealSpeed",
		prerequisite = "medic_heal_2",
		data = {
			speed = {5,"add"}
		}
	},
	{
		id = "taser_overcharge_rpt_",
		icon = "crime_spree_taser_overcharge",
		class = "ModifierTaserOvercharge",
		prerequisite = "taser_overcharge",
		data = {
			speed = {10,"add"}
		}
	},
	{
		id = "medic_rpt_",
		icon = "crime_spree_more_medics",
		class = "ModifierMoreMedics",
		prerequisite = "medic_2",
		data = {
			inc = {1,"add"}
		}
	},
	{
		id = "dozer_rage_rpt_",
		icon = "crime_spree_dozer_rage",
		class = "ModifierDozerRage",
		prerequisite = "dozer_rage",
		data = {
			damage = {10,"add"}
		}
	},
	{
		id = "dozer_rpt_",
		icon = "crime_spree_more_dozers",
		class = "ModifierMoreDozers",
		prerequisite = "dozer_2",
		data = {
			inc = {1,"add"}
		}
	},
	{
		id = "medic_adrenaline_rpt_",
		icon = "crime_spree_medic_adrenaline",
		class = "ModifierMedicAdrenaline",
		prerequisite = "medic_adrenaline",
		data = {
			damage = {5,"add"}
		}
	},
	{
		id = "medic_rage_rpt_",
		icon = "crime_spree_medic_rage",
		class = "ModifierMedicRage",
		prerequisite = "medic_rage",
		data = {
			damage = {10,"add"}
		}
	},
    {
        id = "tazer_rpt_",
        icon = "crime_spree_more_medics",
        class = "ModifierMoreTazers",
        data = {
            inc = {1,"add"}
        }
    }
}
tweak_data.crime_spree.repeating_modifiers["stealth"] = {
	{
		id = "conceal_rpt_",
		icon = "crime_spree_concealment",
		class = "ModifierLessConcealment",
		prerequisite = "conceal_2",
		data = {
			conceal = {1,"add"}
		}
	}
}

for i,v in ipairs(tweak_data.crime_spree.modifiers.loud) do
	if v.id == "medic_heal_2" then v.prerequisite = "medic_heal_1"
	elseif v.id == "dozer_2" then v.prerequisite = "dozer_1"
	elseif v.id == "medic_2" then v.prerequisite = "medic_1"
	elseif v.id == "shield_phalanx" then v.prerequisite = "shield_reflect"
	elseif v.id == "dozer_immunity" then v.prerequisite = "shield_reflect"
	elseif v.id == "cloaker_tear_gas" then v.prerequisite = "cloaker_smoke"
	end
end
for i,v in ipairs(tweak_data.crime_spree.modifiers.stealth) do
	if v.id == "pagers_2" then v.prerequisite = "pagers_1"
	elseif v.id == "pagers_3" then v.prerequisite = "pagers_2"
	elseif v.id == "pagers_4" then v.prerequisite = "pagers_3"
	elseif v.id == "civs_2" then v.prerequisite = "civs_1"
	elseif v.id == "civs_3" then v.prerequisite = "civs_2"
	elseif v.id == "conceal_2" then v.prerequisite = "conceal_1"
	end
end

if _G.ModifierMoreMedics and not _G.ModifierMoreMedics.total_localization then
	_G.ModifierMoreMedics.total_localization = "menu_cs_modifier_medics_total"
end
if _G.ModifierMoreDozers and not _G.ModifierMoreMedics.total_localization then
	_G.ModifierMoreDozers.total_localization = "menu_cs_modifier_dozers_total"
end
if _G.ModifierMedicRage and not _G.ModifierMedicRage.total_localization then
	_G.ModifierMedicRage.total_localization = "menu_cs_modifier_medic_rage_total"
end
if _G.ModifierTaserOvercharge and not _G.ModifierTaserOvercharge.total_localization then
	_G.ModifierTaserOvercharge.total_localization = "menu_cs_modifier_taser_overcharge_total"
end
if _G.ModifierHealSpeed and not _G.ModifierHealSpeed.total_localization then
	_G.ModifierHealSpeed .total_localization = "menu_cs_modifier_medic_heal_total"
end


Hooks:Add("LocalizationManagerPostInit","parametrise_modifiers", function(loc)
	LocalizationManager:add_localized_strings({
		["menu_cs_modifier_medics"] = "$inc; additional medics are allowed into the level",
		["menu_cs_modifier_dozers"] = "$inc; additional Bulldozers are allowed into the level",
		["menu_cs_modifier_medics_total"] = "(Total: +$inc; medics)",
		["menu_cs_modifier_dozers_total"] = "(Total: +$inc; Bulldozers)",
		["menu_cs_modifier_medic_rage_total"] = "(Total: +$inc;%)",
		["menu_cs_modifier_taser_overcharge_total"] = "(Total: +$speed;%)",
		["menu_cs_modifier_medic_heal_total"] = "(Total: +$inc;%)",
		["menu_cs_modifier_civilian_pager"] = "Killing civilians activates their pagers",
        ["menu_cs_modifier_more_tazers"] = "$inc; additional medics are allowed into the level"
	})
end)

Hooks:OverrideFunction(CrimeSpreeManager, "get_loud_modifiers", function(self)
	return self:_get_modifiers("loud", tweak_data.crime_spree.max_modifiers_displayed, true)
end)
