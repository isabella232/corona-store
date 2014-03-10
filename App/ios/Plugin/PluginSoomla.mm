//
//  PluginSoomla.mm
//  Soomla for Corona
//
//  Copyright (c) 2014 Soomla. All rights reserved.

#import "PluginSoomla.h"
#import <UIKit/UIKit.h>
#import "SoomlaStore.h"

#import "NSDictionary+CreateFromLua.h"
#import "SoomlaStore.h"
#import "VirtualCurrency.h"

PluginSoomla::PluginSoomla() {}

PluginSoomla * PluginSoomla::GetLibrary(lua_State * L) {
    PluginSoomla * soomla = (PluginSoomla *) CoronaLuaToUserdata(L,lua_upvalueindex(1));
    return soomla;
}

int PluginSoomla::createCurrency(lua_State * L) {
    NSDictionary * currencyData = [NSDictionary dictionaryFromLua:L tableIndex:lua_gettop(L)];
    VirtualCurrency * currency = [[VirtualCurrency alloc] initWithDictionary:currencyData];
    if(currency.itemId == nil) NSLog(@"SOOMLA: itemId shouldn't be empty! The currency %@ won't be added to the Store",currency.name);
    else [[SoomlaStore sharedInstance] addVirtualItem:currency];
    lua_pushstring(L,[currency.itemId cStringUsingEncoding:NSUTF8StringEncoding]);
    return 1;
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