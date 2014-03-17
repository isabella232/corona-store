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
    
    NSString * goodId = [luaData objectForKey:kUpgradeVG_LinkedGood];
    if([goodId isEqualToString:@""] || [goodId isKindOfClass:[NSNull class]]) {
        NSLog(@"SOOMLA: goodItemId can't be null for UpgradeVG %@. The Virtual Good won't be created.",self.name);
        return nil;
    }
    
    self.goodItemId = goodId;
    NSString * previousUpgrade = [luaData objectForKey:kUpgradeVG_Previous];
    self.prevGoodItemId = ([prevGoodItemId isKindOfClass:[NSNull class]]) ? @"" : previousUpgrade;
    NSString * nextUpgrade = [luaData objectForKey:kUpgradeVG_Next];
    self.prevGoodItemId = ([prevGoodItemId isKindOfClass:[NSNull class]]) ? @"" : nextUpgrade;
    
    return self;
}

@end
