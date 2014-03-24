//
//  PluginSoomla.h
//  Soomla for Corona
//
//  Copyright (c) 2014 Soomla. All rights reserved.

#ifndef _PluginSoomla_H__
#define _PluginSoomla_H__

#include "CoronaLua.h"
#include "CoronaLibrary.h"
#include "CoronaRuntime.h"

@class NSDictionary;
@class VirtualItem;

CORONA_EXPORT void soomla_throwEvent(NSDictionary * eventData);
CORONA_EXPORT int luaopen_plugin_soomla(lua_State *L);


#endif // _PluginSoomla_H__
