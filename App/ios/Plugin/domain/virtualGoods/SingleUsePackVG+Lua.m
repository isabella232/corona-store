//
//  SingleUsePackVG+Lua.m
//  Plugin
//
//  Created by Bruno Barbosa Pinheiro on 3/13/14.
//
//

#import "SingleUsePackVG+Lua.h"
#import "PurchasableVirtualItem+Lua.h"

#define kSingleUsePack_SingleUseId      @"singleUseVG"
#define kSingleUsePack_Amount           @"amount"

@implementation SingleUsePackVG (Lua)

- (id) initFromLua:(NSDictionary *) luaData {
    
    self = [super initFromLua:luaData];
    if(self == nil) return nil;
    
    self.goodItemId = [luaData objectForKey:kSingleUsePack_SingleUseId];
    NSNumber * goodAmount = [luaData objectForKey:kSingleUsePack_Amount];
    self.amount = [goodAmount intValue];
    
    return self;
}

@end
