package com.soomla.corona;

import com.soomla.store.domain.VirtualItem;

public class VirtualItem_Lua {

	private static final String KEY_NAME 			= "name";
	private static final String KEY_DESCRIPTION		= "description";
	private static final String KEY_ITEMID			= "itemId";
	private static final String KEY_CLASS			= "class";

	public static VirtualItem createFromLua(Map<String,Object> luaTable) {
		if(!luaTable.containsKey(KEY_ITEMID)) {
			System.out.println("SOOMLA: " + KEY_ITEMID + " can't be null!");
			return NULL;
		}

		String itemId = luaTable.get(KEY_ITEMID);
		String name = "";
		String description = "";
		if(luaTable.containsKey(KEY_NAME)) name = luaTable.get(KEY_NAME);
		if(luaTable.containsKey(KEY_DESCRIPTION)) description = luaTable.get(KEY_DESCRIPTION);

		return new VirtualItem(name,description,itemId);
	}

}