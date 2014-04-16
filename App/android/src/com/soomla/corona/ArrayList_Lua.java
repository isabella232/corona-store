package com.soomla.corona;

import java.util.ArrayList;
import java.lang.Double;
import java.lang.String;
import com.naef.jnlua.LuaState;
import com.naef.jnlua.LuaType;
import com.soomla.corona.Map_Lua;

public class ArrayList_Lua {

    public static void arrayToLua(ArrayList<Object> array, LuaState L) {
        Lua.newTable();
        int index = 1;
        for(Object value : array) {
            if(value instanceof String) L.pushString(value);
            if(value instanceof Double) L.pushNumber(((Double) value).doubleValue());
            if(value instanceof Map) Map_Lua.mapToLua(value,L);
            if(value instanceof ArrayList) ArrayList_Lua.arrayToLua(value,L);
            L.rawSet(-2,index);
            index++;
        }
    }

}
