package com.soomla.corona;

import java.util.ArrayList;
import java.util.Map;
import java.util.Map.Entry;
import java.util.HashMap;
import java.lang.Double;
import java.lang.String;
import com.naef.jnlua.LuaState;
import com.naef.jnlua.LuaType;
import com.soomla.corona.ArrayList_Lua;

public class Map_Lua {

	private static final int LUATABLE_INDEX 	= -2;
	private static final int LUATABLE_KEY 		= -1;
	private static final int LUATABLE_VALUE 	= -2;

	public static Map<String,Object> mapFromLua(LuaState L,int tableIndex) {
		Map<String,Object> map = new HashMap<String,Object>();
		if(!L.isTable(tableIndex)) {
			System.out.println("SOOMLA: There's no table at index: " + tableIndex);
			return null;
		}
		L.pushValue(tableIndex);
		L.pushNil();
		while(L.next(LUATABLE_INDEX)) {
			L.pushValue(-2);
			String key;
			if(L.isString(LUATABLE_KEY)) key = L.toString(LUATABLE_KEY);
			else key = String.valueOf(L.toNumber(LUATABLE_KEY));

			switch(L.type(LUATABLE_VALUE)) {
				case STRING: 
					String valueString = L.toString(LUATABLE_VALUE);
					map.put(key,valueString);
				break;

				case NUMBER: 
					double valueNumber = L.toNumber(LUATABLE_VALUE);
					map.put(key,new Double(valueNumber));
				break;
				
				case BOOLEAN: 
					boolean valueBoolean = L.toBoolean(LUATABLE_VALUE);
					map.put(key,new Boolean(valueBoolean));
				break;

				case TABLE: 
					Map<String,Object> valueTable = Map_Lua.mapFromLua(L,LUATABLE_VALUE);
					map.put(key,valueTable);
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
            if(value instanceof String) L.pushString((String)value);
            if(value instanceof Double) L.pushNumber(((Double)value).doubleValue());
            if(value instanceof Map) Map_Lua.mapToLua((Map<String,Object>)value,L);
            if(value instanceof ArrayList) ArrayList_Lua.arrayToLua((ArrayList<Object>)value,L);
            L.setField(-2,key);
        }
    }

    public static String mapToLuaString(Map<String,Object> map) {
        String luaTable = "{ ";
        for(Entry<String,Object> entry : map.entrySet() ) {
            String key = entry.getKey();
            luaTable = luaTable + key + " =";
            Object value = entry.getValue();
            if(value instanceof String) luaTable = luaTable + (String)value + ", ";
            if(value instanceof Double) luaTable = luaTable + (Double)value + ", ";
            if(value instanceof Map) luaTable = luaTable + Map_Lua.mapToLuaString((Map<String,Object>)value) + ", ";
            if(value instanceof ArrayList) luaTable = luaTable + ArrayList_Lua.arrayToLuaString((ArrayList<Object>)value) + ", ";
        }
        luaTable = luaTable + "}";
        return luaTable;
    }

}
