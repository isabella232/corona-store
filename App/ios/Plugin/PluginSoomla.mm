//
//  PluginSoomla.mm
//  Soomla for Corona
//
//  Copyright (c) 2014 Soomla. All rights reserved.
//

#import "PluginSoomla.h"
#import <UIKit/UIKit.h>
#import "SoomlaStore.h"

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

const char PluginSoomla::kChronometerEvent[] = "soomla_chronometer";

int PluginSoomla::start(lua_State * L) {
    PluginSoomla::runTimer();
    return 0;
}

void PluginSoomla::throwEvent() {
    lua_State * L = Corona::Lua::New(255);
    Corona::Lua::PushRuntime(L);
    //const char kEventNameKey[] = "name";
    
    Corona::Lua::NewEvent(L,kChronometerEvent);
    
    //lua_newtable(L);
    //printf("Is table? %d\n",lua_istable(L,-1));
    //lua_pushstring(L,kChronometerEvent);
    //printf("Is table? %d\n",lua_istable(L,-2));
    //lua_setfield(L,-2,kEventNameKey);
    
    Corona::Lua::RuntimeDispatchEvent(L,-1);
}

void PluginSoomla::runTimer() {
    double delayInSeconds = 2;
    dispatch_time_t eventTime = dispatch_time(DISPATCH_TIME_NOW,delayInSeconds * NSEC_PER_SEC);
    dispatch_after(eventTime,dispatch_get_main_queue(), ^(void) {
        PluginSoomla::throwEvent();
        PluginSoomla::runTimer();
    });

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
        { "start", start },
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