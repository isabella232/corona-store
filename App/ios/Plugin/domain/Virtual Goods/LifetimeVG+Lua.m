//
//  LifetimeVG+Lua.m
//  Plugin
//
//  Created by Bruno Barbosa Pinheiro on 3/13/14.
//
//

#import "LifetimeVG+Lua.h"
#import "LuaTableKeys.h"
#import "PurchaseType+Lua.h"

@implementation LifetimeVG (Lua)

+ (LifetimeVG *) lifetimeVGFromLua:(NSDictionary *)luaData {
    NSString * name = [luaData objectForKey:kVirtualItem_Name];
    NSString * description = [luaData objectForKey:kVirtualItem_Description];
    NSString * itemId = [luaData objectForKey:kVirtualItem_ItemId];
    NSDictionary * productData = [luaData objectForKey:kPurchasableVirtualItem_Purchase];
    PurchaseType * purchase = [PurchaseType purchaseTypeFromLua:productData];
    return [[LifetimeVG alloc] initWithName:name andDescription:description andItemId:itemId andPurchaseType:purchase];
}

@end
