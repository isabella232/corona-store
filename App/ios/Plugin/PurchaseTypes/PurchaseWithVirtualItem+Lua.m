//
//  PurchaseWithVirtualItem+Lua.m
//  Plugin
//
//  Created by Bruno Barbosa Pinheiro on 3/20/14.
//
//

#import "PurchaseWithVirtualItem+Lua.h"
#import "PurchaseType+Lua.h"

@implementation PurchaseWithVirtualItem (Lua)

- (NSDictionary *) toLuaDictionary {
    return @{
             @"type" : kPurchaseType_VirtualItem,
             kPurchaseType_ExchangeCurrency : @{
                     kPurchaseType_ItemId : self.targetItemId,
                     kPurchaseType_Amount : [NSNumber numberWithInt:self.amount]
             }
    };
}

@end
