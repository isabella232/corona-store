//
//  SingleUsePackVG+Lua.m
//  Plugin
//
//  Created by Bruno Barbosa Pinheiro on 3/13/14.
//
//

#import "SingleUsePackVG+Lua.h"
#import "PurchasableVirtualItem+Lua.h"

#define kSingleUsePack_SingleUseId      @"singleUseGood"
#define kSingleUsePack_Amount           @"amount"

@implementation SingleUsePackVG (Lua)

- (id) initFromLua:(NSDictionary *) luaData {
    
    self = [super initFromLua:luaData];
    if(self == nil) return nil;

    NSString * goodId = [luaData objectForKey:kSingleUsePack_SingleUseId];
    if([goodItemId isEqualToString:@""] || [goodItemId isKindOfClass:[NSNull class]]) {
        NSLog(@"SOOMLA: goodItemId can't be null for SingleUsePackVG %@. The Virtual Good won't be created!",self.name);
        return nil;
    }
    
    self.goodItemId = goodId;
    NSNumber * goodAmount = [luaData objectForKey:kSingleUsePack_Amount];
    self.amount = [goodAmount intValue];
    return self;
}

@end
