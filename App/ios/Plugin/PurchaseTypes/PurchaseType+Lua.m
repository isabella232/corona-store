//
//  PurchaseType+Lua.m
//  Plugin
//
//  Created by Bruno Barbosa Pinheiro on 3/11/14.
//
//

#import "PurchaseType+Lua.h"
#import "PurchaseWithMarket.h"
#import "PurchaseWithVirtualItem.h"
#import "AppStoreItem+Lua.h"
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
    AppStoreItem * storeItem = [AppStoreItem appStoreItemFromLua:productData];
    if([storeItem isKindOfClass:[NSNull class]] || storeItem == nil) return nil;
    PurchaseWithMarket * marketPurchase = [[PurchaseWithMarket alloc] initWithAppStoreItem:storeItem];
    return marketPurchase;
}

+ (PurchaseType *) virtualItemPurchaseFromLua:(NSDictionary *) luaData {
    NSDictionary * exchange = [luaData objectForKey:kPurchaseType_ExchangeCurrency];
    NSString * itemId = [exchange objectForKey:kPurchaseType_ItemId];
    if([itemId isEqualToString:@""] || [itemId isKindOfClass:[NSNull class]] || itemId == nil) {
        NSLog(@"SOOMLA: itemId can't be null for the PurchaseWithVirtualItem.");
        return nil;
    }
    NSNumber * amount = [exchange objectForKey:kPurchaseType_Amount];
    return [[PurchaseWithVirtualItem alloc] initWithVirtualItem:itemId andAmount:[amount intValue]];
}

- (NSDictionary *) toLuaDictionary {
    return @{};
}

@end
