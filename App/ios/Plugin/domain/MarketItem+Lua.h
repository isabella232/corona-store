//
//  AppStoreItem+Lua.h
//  Plugin
//
//  Created by Bruno Barbosa Pinheiro on 3/11/14.
//
//

#import <Foundation/Foundation.h>
#import "MarketItem.h"

@interface MarketItem (Lua)

+ (MarketItem *) appStoreItemFromLua:(NSDictionary *) luaData;
- (NSDictionary *) toLuaDictionary;

@end
