//
//  VirtualCurrencyPack+Lua.m
//  Plugin
//
//  Created by Bruno Barbosa Pinheiro on 3/11/14.
//
//

#import "VirtualCurrencyPack+Lua.h"
#import "PurchaseType+Lua.h"

@implementation VirtualCurrencyPack (Lua)

+ (VirtualCurrencyPack *) currencyPackFromLua:(NSDictionary *) luaData {
    VirtualCurrencyPack * currencyPack = [VirtualCurrencyPack alloc];
    
    //TODO: Validate all the data
    
    NSString * name = [luaData objectForKey:@"name"];
    NSString * description = [luaData objectForKey:@"description"];
    NSString * itemId = [luaData objectForKey:@"itemId"];
    
    NSDictionary * purchase = [luaData objectForKey:@"purchase"];
    PurchaseType * purchaseType = [PurchaseType purchaseTypeFromLua:purchase];
    
    [currencyPack initWithName:name andDescription:description andItemId:itemId andPurchaseType:purchaseType];
    return currencyPack;
}

@end
