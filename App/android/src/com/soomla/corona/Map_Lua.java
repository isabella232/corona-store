package com.soomla.corona;

import java.util.ArrayList;
import java.lang.Double;
import java.lang.String;
import com.naef.jnlua.LuaState;
import com.naef.jnlua.LuaType;
import com.soomla.corona.ArraList_Lua;

public class Map_Lua {

	private static final int LUATABLE_INDEX 	= -2;
	private static final int LUATABLE_KEY 		= -1;
	private static final int LUATABLE_VALUE 	= -2;

	public static Map<String,Object> mapFromLua(LuaState L,int tableIndex) {
		Map<String,Object> map = new HashMap<String,Object>();
		if(!L.isTable(tableIndex)) {
			System.out.println("SOOMLA: There's no table at index: " + tableIndex);
			return NULL;
		}
		L.pushValue(tableIndex);
		L.pushNil();
		while(L.next(LUATABLE_INDEX) != 0) {
			L.pushValue(-2);
			String key;
			if(L.isString(LUATABLE_KEY)) key = L.toString(LUATABLE_KEY);
			else key = String.valueOf(L.toNumber(LUATABLE_KEY));

			switch(L.type(LUATABLE_VALUE)) {
				case STRING: 
					String value = L.toString(LUATABLE_VALUE);
					map.put(key,value);
				break;

				case NUMBER: 
					double value = L.toNumber(LUATABLE_VALUE);
					map.put(key,new Double(value));
				break;
				
				case BOOLEAN: 
					boolean value = L.toBoolen(LUATABLE_VALUE);
					map.put(key,new Boolean(value));
				break;

				case TABLE: 
					Map<String,Object> value = Map_Lua.MapFromLua(L,LUATABLE_VALUE);
					map.put(key,value);
				break;

				default: 
					//Skipping not supported values
				break;
			}
			L.pop(2);
		}
		L.pop(1);
		return map;
	}

    public static void mapToLua(Map<String,Object> map, LuaState L) {
        L.newTable();
        for(Entry<String,Object> entry : map.entrySet() ) {
            String key = entry.getKey();
            Object value = entry.getValue();
            if(value instanceof String) L.pushString(value);
            if(value instanceof Double) L.pushNumber(((Double)value).doubleValue());
            if(value instanceof Map) Map_Lua.mapToLua(value,L);
            if(value instanceof ArrayList) ArrayList_Lua.arrayToLua(value,L);
            L.setField(-2,key);
        }
    }

}
