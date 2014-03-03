//
//  PluginSoomla.h
//  Soomla for Corona SDK
//
//  Copyright (c) 2014 Soomla. All rights reserved.
//

#ifndef _PluginSoomla_H__
#define _PluginSoomla_H__

#include "CoronaLua.h"
#include "CoronaMacros.h"

CORONA_EXPORT int luaopen_plugin_soomla( lua_State *L );

//The Soomla plugin class is defined here
class PluginSoomla {
    
public:
    static const char kName[];
    static int Export(lua_State * L);
    static int sum(lua_State * L);
    
protected:
    PluginSoomla();
    static int Finalizer(lua_State * L);
    static PluginSoomla * GetLibrary(lua_State * L);
    
};

#endif // _PluginSoomla_H__
