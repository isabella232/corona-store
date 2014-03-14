//
//  VirtualCurrencyPack+Lua.m
//  Plugin
//
//  Created by Bruno Barbosa Pinheiro on 3/14/14.
//
//

#import "VirtualCurrencyPack+Lua.h"
#import "PurchasableVirtualItem+Lua.h"

#define kCurrencyPack_CurrencyId    @"currency"
#define kCurrencyPack_Amount        @"amount"

@implementation VirtualCurrencyPack (Lua)

- (id) initFromLua:(NSDictionary *)luaData {
    
    self = [super initFromLua:luaData];
    if(self == nil) return nil;
    
    self.currencyItemId = [luaData objectForKey:kCurrencyPack_CurrencyId];
    NSNumber * amount = [luaData objectForKey:kCurrencyPack_Amount];
    self.currencyAmount = [amount intValue];
    
    return self;
}

@end
