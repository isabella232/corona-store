//
//  PurchasableVirtualItem+Lua.m
//  Plugin
//
//  Created by Bruno Barbosa Pinheiro on 3/13/14.
//
//

#import "PurchasableVirtualItem+Lua.h"
#import "VirtualItem+Lua.h"
#import "PurchaseType+Lua.h"

#define kPurchasableVirtualItem_Purchase        @"purchase"

@implementation PurchasableVirtualItem (Lua)

- (id) initFromLua:(NSDictionary *) luaData {
    
    self = [super initFromLua:luaData];
    if(self == nil) return nil;
    
    //TODO: Validate purchase
    NSDictionary * purchaseData = [luaData objectForKey:kPurchasableVirtualItem_Purchase];
    self.purchaseType = [PurchaseType purchaseTypeFromLua:purchaseData];
    return self;
}

@end
