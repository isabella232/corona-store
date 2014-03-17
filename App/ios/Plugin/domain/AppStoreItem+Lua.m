//
//  AppStoreItem+Lua.m
//  Plugin
//
//  Created by Bruno Barbosa Pinheiro on 3/11/14.
//
//

#import "AppStoreItem+Lua.h"

#define kAppStoreItem_ProductId         @"id"
#define kAppStoreItem_Consumable        @"consumable"
#define kAppStoreItem_Price             @"price"
#define kConsumable_Consumable          @"consumable"
#define kConsumable_NonConsumable       @"nonConsumable"
#define kConsumable_AutoRenewable       @"autoRenewableSubscription"
#define kConsumable_NonRenewable        @"nonRenewableSubscription"
#define kConsumable_FreeSubscription    @"freeSubscription"

@implementation AppStoreItem (Lua)

+ (AppStoreItem *) appStoreItemFromLua:(NSDictionary *) luaData {
    
    NSString * productId = [luaData objectForKey:kAppStoreItem_ProductId];
    if([productId isEqualToString:@""] || [productId isKindOfClass:[NSNull class]] || productId == nil) {
        NSLog(@"SOOMLA: %@ can't be null for a Market Product",kAppStoreItem_ProductId);
        return nil;
    }
    
    NSNumber * price = [luaData objectForKey:kAppStoreItem_Price];
    
    NSString * consumable = [luaData objectForKey:kAppStoreItem_Consumable];
    int consumableId = -1;
    if([consumable isEqualToString:kConsumable_Consumable])             consumableId = kConsumable;
    else if([consumable isEqualToString:kConsumable_NonConsumable])     consumableId = kNonConsumable;
    else if([consumable isEqualToString:kConsumable_AutoRenewable])     consumableId = kAutoRenewableSubscription;
    else if([consumable isEqualToString:kConsumable_NonRenewable])      consumableId = kNonRenewableSubscription;
    else if([consumable isEqualToString:kConsumable_FreeSubscription])  consumableId = kFreeSubscription;
    
    AppStoreItem * storeItem = [[AppStoreItem alloc] initWithProductId:productId
                                                         andConsumable:(Consumable)consumableId
                                                              andPrice:[price doubleValue]];
    
    return storeItem;
}

@end
