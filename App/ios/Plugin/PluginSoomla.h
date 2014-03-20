//
//  PluginSoomla.h
//  Soomla for Corona
//
//  Copyright (c) 2014 Soomla. All rights reserved.

#ifndef _PluginSoomla_H__
#define _PluginSoomla_H__

#include "CoronaLua.h"
#include "CoronaLibrary.h"

@class NSDictionary;
@class VirtualItem;

CORONA_EXPORT int luaopen_plugin_soomla(lua_State *L);

//The Soomla plugin class is defined here
class PluginSoomla {
    
public:
    //Creating models
    static int createCurrency(lua_State * L);
    static int createCurrencyPack(lua_State * L);
    static int createSingleUseVG(lua_State * L);
    static int createLifetimeVG(lua_State * L);
    static int createEquippableVG(lua_State * L);
    static int createSingleUsePackVG(lua_State * L);
    static int createUpgradeVG(lua_State * L);
    static int createNonConsumableItem(lua_State * L);
    static int createVirtualCategory(lua_State * L);
    
    //Initialize the Store
    static int initializeStore(lua_State *L);
    
    //Events
    static void throwEvent(lua_State * L);
    
    //CORONA EXPORT
    static const char kName[];
    static int Export(lua_State * L);

    
protected:
    PluginSoomla();
    static int Finalizer(lua_State * L);
    static PluginSoomla * getLibrary(lua_State * L);
    static NSDictionary * getDictionaryFromLuaState(lua_State * L);
    static void addVirtualItemForLuaState(VirtualItem * virtualItem,lua_State * L);
    static void setListener(lua_State * L, int storeListenerIndex);
    
private:
    CoronaLuaRef eventsListener;
};

#endif // _PluginSoomla_H__
