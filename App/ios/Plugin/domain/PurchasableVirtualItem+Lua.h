//
//  PurchasableVirtualItem+Lua.h
//  Plugin
//
//  Created by Bruno Barbosa Pinheiro on 3/13/14.
//
//

#import "PurchasableVirtualItem.h"

@interface PurchasableVirtualItem (Lua)

- (id) initFromLua:(NSDictionary *) luaData;
- (NSDictionary *) toLuaDictionary;

@end
