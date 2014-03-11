//
//  AppStoreItem+Lua.h
//  Plugin
//
//  Created by Bruno Barbosa Pinheiro on 3/11/14.
//
//

#import <Foundation/Foundation.h>
#import "AppStoreItem.h"

@interface AppStoreItem (Lua)

+ (AppStoreItem *) appStoreItemFromLua:(NSDictionary *) luaData;

@end
