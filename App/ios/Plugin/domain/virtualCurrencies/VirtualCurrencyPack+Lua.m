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
        NSLog(@"SOOMLA: %@ can't be null for CurrencyPack %@.",kCurrencyPack_CurrencyId,self.itemId);
        return nil;
    }
    self.currencyItemId = currencyId;
    
    
    NSNumber * amount = [luaData objectForKey:kCurrencyPack_Amount];
    if([amount isKindOfClass:[NSNull class]] || amount == nil) {
        NSLog(@"SOOMLA: %@ can't be null for CurrencyPack %@.",kCurrencyPack_Amount,self.itemId);
        return nil;
    }
    if(amount < 0) {
        NSLog(@"SOOMLA: %@ should be greater than 0 for Currency Pack %@.",kCurrencyPack_Amount,self.itemId);
        return nil;
    }
    self.currencyAmount = [amount intValue];
    
    return self;
}

- (NSDictionary *) toLuaDictionary {
    NSMutableDictionary * luaDictionary = [NSMutableDictionary dictionaryWithDictionary:[super toLuaDictionary]];
    [luaDictionary setValue:self.currencyItemId forKey:kCurrencyPack_CurrencyId];
    [luaDictionary setValue:[NSNumber numberWithInt:self.currencyAmount] forKey:kCurrencyPack_Amount];
    return [NSDictionary dictionaryWithDictionary:luaDictionary];
}

@end
