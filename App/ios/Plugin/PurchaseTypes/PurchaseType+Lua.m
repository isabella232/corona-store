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

#define kPurchaseType_Market        @"market"
#define kPurchaseType_VirtualItem   @"virtualItem"
#define kPurchaseType_Product       @"product"

@implementation PurchaseType (Lua)

+ (PurchaseType *) purchaseTypeFromLua:(NSDictionary *) luaData {

    NSString * type = [luaData objectForKey:@"type"];
    PurchaseType * purchaseType = nil;
    
    if([type isEqualToString:kPurchaseType_Market]) purchaseType = [PurchaseType marketPurchaseFromLua:luaData];
    else if([type isEqualToString:kPurchaseType_VirtualItem]) purchaseType = [PurchaseType virtualItemPurchaseFromLua:luaData];
    else NSLog(@"SOOMLA: The purchase type %@ is not valid! The avaiable options are: %@ and %@",type,kPurchaseType_Market,kPurchaseType_VirtualItem);
    
    return purchaseType;
}

+ (PurchaseType *) marketPurchaseFromLua:(NSDictionary *) luaData {
    NSDictionary * productData = [luaData objectForKey:kPurchaseType_Product];
    AppStoreItem * storeItem = [AppStoreItem appStoreItemFromLua:productData];
    PurchaseWithMarket * marketPurchase = [[PurchaseWithMarket alloc] initWithAppStoreItem:storeItem];
    return marketPurchase;
}

+ (PurchaseType *) virtualItemPurchaseFromLua:(NSDictionary *) luaData {
    //TODO: Create the Virtual Item Purchase from Product table
}

@end
