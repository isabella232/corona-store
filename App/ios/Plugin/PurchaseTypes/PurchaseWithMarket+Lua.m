//
//  PurchaseWithMarket+Lua.m
//  Plugin
//
//  Created by Bruno Barbosa Pinheiro on 3/20/14.
//
//

#import "PurchaseWithMarket+Lua.h"
#import "PurchaseType+Lua.h"
#import "AppStoreItem+Lua.h"

@implementation PurchaseWithMarket (Lua)

+ (PurchaseWithMarket *) purchaseWithMarketFromLua:(NSDictionary *)luaData {
    AppStoreItem * storeItem = [AppStoreItem appStoreItemFromLua:luaData];
    if([storeItem isKindOfClass:[NSNull class]] || storeItem == nil) return nil;
    return [[PurchaseWithMarket alloc] initWithAppStoreItem:storeItem];
}

- (NSDictionary *) toLuaDictionary {
    return @{
             @"type" : kPurchaseType_Market,
             kPurchaseType_Product : [self.appStoreItem toLuaDictionary]
    };
}

@end
