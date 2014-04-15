package com.soomla.store.corona;

import com.soomla.store.domain.virtualCurrencies.VirtualCurrency;
import com.soomla.corona.Map_Lua;
import com.soomla.corona.VirtualItem_Lua;

public class VirtualCurrency_Lua {

    public static VirtualCurrency createFromLua(Map<String,Object> luaTable) {
    	return VirtualItem_Lua.createFromLua(luaTable);
    }

}
