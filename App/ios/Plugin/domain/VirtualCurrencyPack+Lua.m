//
//  VirtualCurrencyPack+Lua.m
//  Plugin
//
//  Created by Bruno Barbosa Pinheiro on 3/11/14.
//
//

#import "VirtualCurrencyPack+Lua.h"
#import "PurchaseType+Lua.h"
#import "LuaTableKeys.h"

@implementation VirtualCurrencyPack (Lua)

+ (VirtualCurrencyPack *) currencyPackFromLua:(NSDictionary *) luaData {
    VirtualCurrencyPack * currencyPack = [VirtualCurrencyPack alloc];
    
    //TODO: Validate all the data
    
    NSString * name = [luaData objectForKey:kVirtualItem_Name];
    NSString * description = [luaData objectForKey:kVirtualItem_Description];
    NSString * itemId = [luaData objectForKey:kVirtualItem_ItemId];
    
    NSDictionary * purchase = [luaData objectForKey:kPurchasableVirtualItem_Purchase];
    PurchaseType * purchaseType = [PurchaseType purchaseTypeFromLua:purchase];
    
    [currencyPack initWithName:name andDescription:description andItemId:itemId andPurchaseType:purchaseType];
    return currencyPack;
}

@end
