//
//  PurchaseType+Lua.h
//  Plugin
//
//  Created by Bruno Barbosa Pinheiro on 3/11/14.
//
//

#import "PurchaseType.h"
#define kPurchaseType_Market                @"market"
#define kPurchaseType_VirtualItem           @"virtualItem"
#define kPurchaseType_Product               @"product"
#define kPurchaseType_ExchangeCurrency      @"exchangeCurrency"
#define kPurchaseType_ItemId                @"itemId"
#define kPurchaseType_Amount                @"amount"

@interface PurchaseType (Lua)

+ (PurchaseType *) purchaseTypeFromLua:(NSDictionary *) luaData;
- (NSDictionary *) toLuaDictionary;

@end
