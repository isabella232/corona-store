//
//  PluginSoomla.mm
//  Soomla for Corona
//
//  Copyright (c) 2014 Soomla. All rights reserved.

#import "PluginSoomla.h"
#import <UIKit/UIKit.h>
#import "SoomlaStore.h"

#import "VirtualCurrency+InitializeFromLua.h"
#import "NSDictionary+CreateFromLua.h"

//#include "CoronaRuntime.h"

PluginSoomla::PluginSoomla() {}

PluginSoomla * PluginSoomla::GetLibrary(lua_State * L) {
    PluginSoomla * soomla = (PluginSoomla *) CoronaLuaToUserdata(L,lua_upvalueindex(1));
    return soomla;
}

int PluginSoomla::sum(lua_State * L) {
    const int kParameter_SumA = 1;
    const int kParameter_SumB = 2;
    
    double a = lua_tonumber(L,kParameter_SumA);
    double b = lua_tonumber(L,kParameter_SumB);
    
    lua_Number result = a + b;
    lua_pushnumber(L,result);
    
    return 1;
}


int PluginSoomla::createCurrency(lua_State * L) {
    //[VirtualCurrency createFromLuaTable:L];
    NSDictionary * dictionary = [NSDictionary createFromLuaTable:L];
    return 0;
}

//CORONA EXPORT
const char PluginSoomla::kName[] = "plugin.soomla";

int PluginSoomla::Finalizer(lua_State * L) {
    PluginSoomla * soomla = (PluginSoomla *) CoronaLuaToUserdata(L,1);
    
    //TODO: Delete all the Lua References right here!
    
    delete soomla;
    return 0;
}

int PluginSoomla::Export(lua_State * L) {
    const char kMetatableName[] = __FILE__;
    CoronaLuaInitializeGCMetatable(L,kMetatableName,Finalizer);
    
    const luaL_Reg exportTable[] = {
        { "sum", sum },
        { "createCurrency", createCurrency },
        { NULL, NULL }
    };
    
    PluginSoomla * soomla = new PluginSoomla();
    CoronaLuaPushUserdata(L,soomla,kMetatableName);
    
    luaL_openlib(L,kName,exportTable,1);
    return 1;
}

CORONA_EXPORT int luaopen_plugin_soomla(lua_State * L) {
    return PluginSoomla::Export(L);
}