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
    if([goodItemId isEqualToString:@""] || [goodItemId isKindOfClass:[NSNull class]] || goodId == nil) {
        NSLog(@"SOOMLA: %@ can't be null for SingleUsePackVG %@.",kSingleUsePack_SingleUseId,self.itemId);
        return nil;
    }
    self.goodItemId = goodId;
    
    NSNumber * goodAmount = [luaData objectForKey:kSingleUsePack_Amount];
    if([goodAmount isKindOfClass:[NSNull class]] || goodAmount == nil) {
        NSLog(@"SOOMLA: %@ can't be null for SingleUsePackVG %@.",kSingleUsePack_Amount,self.itemId);
        return nil;
    }
    if(goodAmount < 0) {
        NSLog(@"SOOMLA: %@ should be greater than 0 for SingleUsePackVG %@.",kSingleUsePack_Amount,self.itemId);
        return nil;
    }
    self.amount = [goodAmount intValue];
    return self;
}

- (NSDictionary *) toLuaDictionary {
    NSMutableDictionary * luaDictionary = [NSMutableDictionary dictionaryWithDictionary:[super toLuaDictionary]];
    [luaDictionary setValue:self.goodItemId forKey:kSingleUsePack_SingleUseId];
    [luaDictionary setValue:[NSNumber numberWithInt:self.amount] forKey:kSingleUsePack_Amount];
    return [NSDictionary dictionaryWithDictionary:luaDictionary];
}

@end
