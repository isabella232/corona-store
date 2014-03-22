//
//  PluginSoomla.mm
//  Soomla for Corona
//
//  Copyright (c) 2014 Soomla. All rights reserved.

#import "PluginSoomla.h"
#import "SoomlaStore.h"

#import "NSDictionary+Lua.h"
#import "VirtualItem+Lua.h"
#import "PurchasableVirtualItem+Lua.h"
#import "SoomlaStore.h"
#import "VirtualCurrency.h"
#import "VirtualCurrencyPack+Lua.h"
#import "SingleUseVG.h"
#import "LifetimeVG.h"
#import "EquippableVG+Lua.h"
#import "SingleUsePackVG+Lua.h"
#import "UpgradeVG+Lua.h"
#import "NonConsumableItem.h"
#import "VirtualCategory+Lua.h"
#import "EventListener.h"

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
    
    //Retrieving models data
    static int getCurrency(lua_State * L);
    static int getCurrencyPack(lua_State * L);
    static int getSingleUseVG(lua_State * L);
    static int getLifetimeVG(lua_State * L);
    static int getEquippableVG(lua_State * L);
    static int getSingleUsePackVG(lua_State * L);
    static int getUpgradeVG(lua_State * L);
    static int getNonConsumableItem(lua_State * L);
    static int getVirtualCategory(lua_State * L);
    
    //Initialize the Store
    static int initializeStore(lua_State * L);
    
    //Events
    static void throwEvent(NSDictionary * eventData);
    
    //CORONA EXPORT
    static const char kName[];
    static int Export(lua_State * L);
    
    
protected:
    PluginSoomla(lua_State * L);
    static int Finalizer(lua_State * L);
    static PluginSoomla * getLibrary(lua_State * L);
    static NSDictionary * getDictionaryFromLuaState(lua_State * L);
    static void addVirtualItemForLuaState(VirtualItem * virtualItem,lua_State * L);
    static int getVirtualItem(lua_State * L);
    
private:
    static id<CoronaRuntime> runtime;
};

PluginSoomla::PluginSoomla(lua_State * L) {
    runtime = (id<CoronaRuntime>)CoronaLuaGetContext(L);
}

id<CoronaRuntime> PluginSoomla::runtime = NULL;

PluginSoomla * PluginSoomla::getLibrary(lua_State * L) {
    PluginSoomla * soomla = (PluginSoomla *) CoronaLuaToUserdata(L,lua_upvalueindex(1));
    return soomla;
}

NSDictionary * PluginSoomla::getDictionaryFromLuaState(lua_State * L) {
    return [NSDictionary dictionaryFromLua:L tableIndex:lua_gettop(L)];
}

#pragma mark - Creating Models
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
    UpgradeVG * upgradeVG = [[UpgradeVG alloc] initFromLua:PluginSoomla::getDictionaryFromLuaState(L)];
    PluginSoomla::addVirtualItemForLuaState(upgradeVG,L);
    return 1;
}

int PluginSoomla::createNonConsumableItem(lua_State * L) {
    NonConsumableItem * nonConsumableItem = [[NonConsumableItem alloc] initFromLua:PluginSoomla::getDictionaryFromLuaState(L)];
    PluginSoomla::addVirtualItemForLuaState(nonConsumableItem,L);
    return 1;
}

void PluginSoomla::addVirtualItemForLuaState(VirtualItem * virtualItem,lua_State * L) {
    if(virtualItem == nil) {
        lua_pushstring(L,[[NSString stringWithFormat:@"invalid!"] cStringUsingEncoding:NSUTF8StringEncoding]);
        return;
    }
    [[SoomlaStore sharedInstance] addVirtualItem:virtualItem];
    lua_pushstring(L,[virtualItem.itemId cStringUsingEncoding:NSUTF8StringEncoding]);
}

int PluginSoomla::createVirtualCategory(lua_State * L) {
    VirtualCategory * virtualCategory = [[VirtualCategory alloc] initFromLua:PluginSoomla::getDictionaryFromLuaState(L)];
    if(virtualCategory.name == nil) {
        NSLog(@"SOOMLA: name shouldn't be empty for a Virtual Category!");
        lua_pushstring(L,[[NSString stringWithFormat:@"invalid!"] cStringUsingEncoding:NSUTF8StringEncoding]);
        return 1;
    }
    [[SoomlaStore sharedInstance] addVirtualCategory:virtualCategory];
    lua_pushstring(L,[virtualCategory.name cStringUsingEncoding:NSUTF8StringEncoding]);
    return 1;
}

#pragma mark - Retrivieng Models Data
int PluginSoomla::getCurrency(lua_State * L) { return PluginSoomla::getVirtualItem(L); }
int PluginSoomla::getCurrencyPack(lua_State * L) { return PluginSoomla::getVirtualItem(L); }
int PluginSoomla::getSingleUseVG(lua_State * L) { return PluginSoomla::getVirtualItem(L); }
int PluginSoomla::getLifetimeVG(lua_State * L) { return PluginSoomla::getVirtualItem(L); }
int PluginSoomla::getSingleUsePackVG(lua_State * L) { return PluginSoomla::getVirtualItem(L); }
int PluginSoomla::getEquippableVG(lua_State * L) { return PluginSoomla::getVirtualItem(L); }
int PluginSoomla::getNonConsumableItem(lua_State * L) { return PluginSoomla::getVirtualItem(L); }
int PluginSoomla::getUpgradeVG(lua_State * L) { return PluginSoomla::getVirtualItem(L); }

int PluginSoomla::getVirtualItem(lua_State * L) {
    const int itemIdParameterIndex = -1;
    NSString * itemId = [NSString stringWithFormat:@"%s",lua_tostring(L,itemIdParameterIndex)];
    VirtualItem * virtualItem = [[SoomlaStore sharedInstance] virtualItemWithId:itemId];
    NSDictionary * virtualItemData = [virtualItem toLuaDictionary];
    [virtualItemData toLuaTable:L];
    return 1;
}


int PluginSoomla::getVirtualCategory(lua_State * L){
    const int nameParameterIndex = -1;
    NSString * name = [NSString stringWithFormat:@"%s",lua_tostring(L,nameParameterIndex)];
    VirtualCategory * category = [[SoomlaStore sharedInstance] categoryWithName:name];
    NSDictionary * categoryData = [category toLuaDictionary];
    [categoryData toLuaTable:L];
    return 1;
}

#pragma mark - Store initialization
int PluginSoomla::initializeStore(lua_State * L) {
    [[SoomlaStore sharedInstance] initializeWithData:PluginSoomla::getDictionaryFromLuaState(L)];
    return 0;
}

#pragma mark - Events
void PluginSoomla::throwEvent(NSDictionary * eventData) {
    lua_State * L = runtime.L;
    [eventData toLuaTable:L];
    CoronaLuaRuntimeDispatchEvent(L,-1);
}

#pragma mark - Corona Export
const char PluginSoomla::kName[] = "plugin.soomla";

int PluginSoomla::Finalizer(lua_State * L) {
    [[EventListener sharedInstance] stopListeningSoomlaEvents];
    
    
    PluginSoomla * soomla = (PluginSoomla *) CoronaLuaToUserdata(L,1);
    //TODO: delete all lua references
    runtime = NULL;
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
        { "createCategory", createVirtualCategory },

        { "getCurrency", getCurrency },
        { "getCurrencyPack", getCurrencyPack },
        { "getSingleUseVG", getSingleUseVG },
        { "getLifetimeVG", getLifetimeVG },
        { "getEquippableVG", getEquippableVG },
        { "getSingleUsePackVG", getSingleUsePackVG },
        { "getUpgradeVG", getUpgradeVG },
        { "getNonConsumableItem", getNonConsumableItem },
        { "getCategory", getVirtualCategory },
        
        { "initializeStore", initializeStore },
        
        { NULL, NULL }
    };
    
    PluginSoomla * soomla = new PluginSoomla(L);
    CoronaLuaPushUserdata(L,soomla,kMetatableName);
    
    luaL_openlib(L,kName,exportTable,1);
    return 1;
}

CORONA_EXPORT int luaopen_plugin_soomla(lua_State * L) {
    int results = PluginSoomla::Export(L);
    [[EventListener sharedInstance] startListeningSoomlaEvents];
    return results;
}

#pragma mark - Global Event Function
void soomla_throwEvent(NSDictionary * eventData) {
    PluginSoomla::throwEvent(eventData);
}

