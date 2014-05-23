//
//  PurchaseType+Lua.m
//  Plugin
//
//  Created by Bruno Barbosa Pinheiro on 3/11/14.
//
//

#import "PurchaseType+Lua.h"
#import "PurchaseWithMarket+Lua.h"
#import "PurchaseWithVirtualItem+Lua.h"
#import "MarketItem+Lua.h"
#import "VirtualItem.h"
#import "SoomlaStore.h"

@implementation PurchaseType (Lua)

+ (PurchaseType *) purchaseTypeFromLua:(NSDictionary *) luaData {
    NSString * type = [luaData objectForKey:@"purchaseType"];
    PurchaseType * purchaseType = nil;
    
    if([type isEqualToString:kPurchaseType_Market]) purchaseType = [PurchaseType marketPurchaseFromLua:luaData];
    else if([type isEqualToString:kPurchaseType_VirtualItem]) purchaseType = [PurchaseType virtualItemPurchaseFromLua:luaData];
    else NSLog(@"SOOMLA: The purchase type %@ is not valid! The avaiable options are: %@ and %@",type,kPurchaseType_Market,kPurchaseType_VirtualItem);
    return purchaseType;
}

+ (PurchaseType *) marketPurchaseFromLua:(NSDictionary *) luaData {
    NSDictionary * productData = [luaData objectForKey:kPurchaseType_Product];
    return [PurchaseWithMarket purchaseWithMarketFromLua:productData];
}

+ (PurchaseType *) virtualItemPurchaseFromLua:(NSDictionary *) luaData {
    NSDictionary * exchange = [luaData objectForKey:kPurchaseType_ExchangeCurrency];
    return [PurchaseWithVirtualItem purchaseWithVirtualItemFromLua:exchange];
}

- (NSDictionary *) toLuaDictionary {
    return @{};
}

@end
