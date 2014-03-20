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
    
    NSString * currencyId = [luaData objectForKey:kCurrencyPack_CurrencyId];
    if([currencyId isEqualToString:@""] || [currencyId isKindOfClass:[NSNull class]] || currencyId == nil) {
        NSLog(@"SOOMLA: %@ can't be null for CurrencyPack %@. The Virtual Good won't be created.",kCurrencyPack_CurrencyId,self.itemId);
        return nil;
    }
    
    self.currencyItemId = currencyId;
    NSNumber * amount = [luaData objectForKey:kCurrencyPack_Amount];
    self.currencyAmount = [amount intValue];
    return self;
}

- (NSDictionary *) toLuaDictionary {
    NSMutableDictionary * luaDictionary = [NSMutableDictionary dictionaryWithDictionary:[super toLuaDictionary]];
    [luaDictionary setValue:self.currencyItemId forKeyPath:kCurrencyPack_CurrencyId];
    [luaDictionary setValue:[NSNumber numberWithInt:self.currencyAmount] forKeyPath:kCurrencyPack_Amount];
    return [NSDictionary dictionaryWithDictionary:luaDictionary];
}

@end
