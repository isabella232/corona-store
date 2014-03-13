//
//  UpgradeVG+Lua.m
//  Plugin
//
//  Created by Bruno Barbosa Pinheiro on 3/13/14.
//
//

#import "UpgradeVG+Lua.h"
#import "PurchasableVirtualItem+Lua.h"

#define kUpgradeVG_LinkedGood       @"linkedGood"
#define kUpgradeVG_Previous         @"previousUpgrade"
#define kUpgradeVG_Next             @"nextUpgrade"

@implementation UpgradeVG (Lua)

- (id) initFromLua:(NSDictionary *)luaData {
    
    self = [super initFromLua:luaData];
    if(self == nil) return nil;
    
    self.goodItemId = [luaData objectForKey:kUpgradeVG_LinkedGood];
    
    NSString * previousUpgrade = [luaData objectForKey:kUpgradeVG_Previous];
    self.prevGoodItemId = ([prevGoodItemId isKindOfClass:[NSNull class]]) ? @"" : previousUpgrade;

    NSString * nextUpgrade = [luaData objectForKey:kUpgradeVG_Next];
    self.prevGoodItemId = ([prevGoodItemId isKindOfClass:[NSNull class]]) ? @"" : nextUpgrade;
    
    return self;
}

@end
