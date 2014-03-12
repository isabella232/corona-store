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
    //TODO: Validate all the data
    
    NSString * name = [luaData objectForKey:kVirtualItem_Name];
    NSString * description = [luaData objectForKey:kVirtualItem_Description];
    NSString * itemId = [luaData objectForKey:kVirtualItem_ItemId];
    NSDictionary * purchaseData = [luaData objectForKey:kPurchasableVirtualItem_Purchase];
    PurchaseType * purchase = [PurchaseType purchaseTypeFromLua:purchaseData];
    
    return [[VirtualCurrencyPack alloc] initWithName:name andDescription:description andItemId:itemId andPurchaseType:purchase];
}

@end
