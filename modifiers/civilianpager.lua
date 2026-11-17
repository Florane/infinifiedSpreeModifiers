Hooks:PreHook(CivilianLogicInactive,"_set_interaction","_set_pager",function(data,my_data)
    managers.modifiers:run_func("trigger_pager",data)
end)

Hooks:PostHook(CivileanLogicInactive,"on_enemy_weapons_hot","on_enemy_weapons_hot_pager",function(data)
    if data.unit:interaction():active() then
        data.unit:interaction():set_active(false, true)
    end
end)
