//
//  PurchaseWithVirtualItem+Lua.m
//  Plugin
//
//  Created by Bruno Barbosa Pinheiro on 3/20/14.
//
//

#import "PurchaseWithVirtualItem+Lua.h"
#import "PurchaseType+Lua.h"

#define kPurchaseType_ItemId                @"itemId"
#define kPurchaseType_Amount                @"amount"

@implementation PurchaseWithVirtualItem (Lua)

+ (PurchaseWithVirtualItem *) purchaseWithVirtualItemFromLua:(NSDictionary *)luaData {
    NSString * itemId = [luaData objectForKey:kPurchaseType_ItemId];
    if([itemId isEqualToString:@""] || [itemId isKindOfClass:[NSNull class]] || itemId == nil) {
        NSLog(@"SOOMLA: %@ can't be null for a PurchaseWithVirtualItem.",kPurchaseType_ItemId);
        return nil;
    }
    
    NSNumber * amount = [luaData objectForKey:kPurchaseType_Amount];
    if([amount isKindOfClass:[NSNull class]] || amount == nil) {
        NSLog(@"SOOMLA: %@ can't be null for a PurchaseWithVirtualItem.",kPurchaseType_Amount);
        return nil;
    }
    if(amount < 0) {
        NSLog(@"SOOMLA: %@ should be greater than 0 for a PurchaseWithVirtualItem",kPurchaseType_Amount);
        return nil;
    }
    
    return [[PurchaseWithVirtualItem alloc] initWithVirtualItem:itemId andAmount:[amount intValue]];
}

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
