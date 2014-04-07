//
//  PurchaseType+Lua.h
//  Plugin
//
//  Created by Bruno Barbosa Pinheiro on 3/11/14.
//
//

#import "PurchaseType.h"
#define kPurchaseType_Product               @"product"
#define kPurchaseType_ExchangeCurrency      @"exchangeCurrency"
#define kPurchaseType_VirtualItem           @"virtualItem"
#define kPurchaseType_Market                @"market"


@interface PurchaseType (Lua)

+ (PurchaseType *) purchaseTypeFromLua:(NSDictionary *) luaData;
- (NSDictionary *) toLuaDictionary;

@end
