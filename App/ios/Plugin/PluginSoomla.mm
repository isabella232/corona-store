//
//  PluginSoomla.mm
//  Soomla for Corona
//
//  Copyright (c) 2014 Soomla. All rights reserved.

#import "PluginSoomla.h"
#import <UIKit/UIKit.h>
#import "SoomlaStore.h"

#import "NSDictionary+CreateFromLua.h"
#import "VirtualItem+Lua.h"
#import "PurchasableVirtualItem+Lua.h"
#import "SoomlaStore.h"
#import "VirtualCurrency.h"
#import "VirtualCurrencyPack.h"
#import "SingleUseVG.h"
#import "LifetimeVG.h"
#import "EquippableVG+Lua.h"
#import "SingleUsePackVG+Lua.h"

PluginSoomla::PluginSoomla() {}

PluginSoomla * PluginSoomla::GetLibrary(lua_State * L) {
    PluginSoomla * soomla = (PluginSoomla *) CoronaLuaToUserdata(L,lua_upvalueindex(1));
    return soomla;
}

NSDictionary * PluginSoomla::getDictionaryFromLuaState(lua_State * L) {
    return [NSDictionary dictionaryFromLua:L tableIndex:lua_gettop(L)];
}

int PluginSoomla::createCurrency(lua_State * L) {
    VirtualCurrency * currency = [[VirtualCurrency alloc] initFromLua:PluginSoomla::getDictionaryFromLuaState(L)];
    PluginSoomla::addVirtualItemForLuaState(currency,L);
    return 1;
}

int PluginSoomla::createCurrencyPack(lua_State * L) {
    VirtualCurrencyPack * currencyPack = [[VirtualCurrencyPack alloc] initFromLua:PluginSoomla::getDictionaryFromLuaState(L)];
    PluginSoomla::addVirtualItemForLuaState(currencyPack,L);
    return 1;
}

int PluginSoomla::createSingleUseVG(lua_State * L) {
    SingleUseVG * singleUseVG = [[SingleUseVG alloc] initFromLua:PluginSoomla::getDictionaryFromLuaState(L)];
    PluginSoomla::addVirtualItemForLuaState(singleUseVG,L);
    return 1;
}

int PluginSoomla::createLifetimeVG(lua_State * L) {
    LifetimeVG * lifetimeVG = [[LifetimeVG alloc] initFromLua:PluginSoomla::getDictionaryFromLuaState(L)];
    PluginSoomla::addVirtualItemForLuaState(lifetimeVG,L);
    return 1;
}

int PluginSoomla::createEquippableVG(lua_State * L) {
    EquippableVG * equippableVG = [[EquippableVG alloc] initFromLua:PluginSoomla::getDictionaryFromLuaState(L)];
    PluginSoomla::addVirtualItemForLuaState(equippableVG,L);
    return 1;
}

int PluginSoomla::createSingleUsePackVG(lua_State * L) {
    SingleUsePackVG * singleUsePackVG = [[SingleUsePackVG alloc] initFromLua:PluginSoomla::getDictionaryFromLuaState(L)];
    PluginSoomla::addVirtualItemForLuaState(singleUsePackVG,L);
    return 1;
}

int PluginSoomla::createUpgradeVG(lua_State * L) {
    //TODO
    return 1;
}

int PluginSoomla::createNonConsumableItem(lua_State * L) {
    //TODO
    return 1;
}



void PluginSoomla::addVirtualItemForLuaState(VirtualItem * virtualItem,lua_State * L) {
    if(virtualItem.itemId == nil) NSLog(@"SOOMLA: itemId shouldn't be empty! The virtual item %@ won't be added to the Store",virtualItem.name);
    else [[SoomlaStore sharedInstance] addVirtualItem:virtualItem];
    lua_pushstring(L,[virtualItem.itemId cStringUsingEncoding:NSUTF8StringEncoding]);
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
        { "createCurrencyPack", createCurrencyPack },
        { "createSingleUseVG", createSingleUseVG },
        { "createLifetimeVG", createLifetimeVG },
        { "createEquippableVG", createEquippableVG },
        { "createSingleUsePackVG", createSingleUsePackVG },
        { "createUpgradeVG", createUpgradeVG },
        { "createNonConsumableItem", createNonConsumableItem },
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