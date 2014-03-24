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
    if([goodId isEqualToString:@""] || [goodId isKindOfClass:[NSNull class]] || goodId == nil) {
        NSLog(@"SOOMLA: %@ can't be null for UpgradeVG %@. The Virtual Good won't be created.",kUpgradeVG_LinkedGood,self.name);
        return nil;
    }
    
    self.goodItemId = goodId;
    NSString * previousUpgrade = [luaData objectForKey:kUpgradeVG_Previous];
    self.prevGoodItemId = ([prevGoodItemId isKindOfClass:[NSNull class]]) ? @"" : previousUpgrade;
    NSString * nextUpgrade = [luaData objectForKey:kUpgradeVG_Next];
    self.prevGoodItemId = ([prevGoodItemId isKindOfClass:[NSNull class]]) ? @"" : nextUpgrade;
    
    return self;
}

- (NSDictionary *) toLuaDictionary {
    NSMutableDictionary * luaDictionary = [NSMutableDictionary dictionaryWithDictionary:[super toLuaDictionary]];
    [luaDictionary setValue:self.goodItemId forKeyPath:kUpgradeVG_LinkedGood];
    [luaDictionary setValue:self.prevGoodItemId forKeyPath:kUpgradeVG_Previous];
    [luaDictionary setValue:self.nextGoodItemId forKeyPath:kUpgradeVG_Next];
    return [NSDictionary dictionaryWithDictionary:luaDictionary];
}

@end
