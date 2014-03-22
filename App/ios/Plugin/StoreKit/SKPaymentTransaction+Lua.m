//
//  SKPaymentTransaction+Lua.m
//  Plugin
//
//  Created by Bruno Barbosa Pinheiro on 3/22/14.
//
//

#import "SKPaymentTransaction+Lua.h"

@implementation SKPaymentTransaction (Lua)

- (NSDictionary *) toLuaDictionary {
    NSMutableDictionary * luaDictionary = [[NSMutableDictionary alloc] init];
    
    switch(self.transactionState) {
        case SKPaymentTransactionStateFailed: break;
        case SKPaymentTransactionStatePurchased: break;
        case SKPaymentTransactionStatePurchasing: break;
        case SKPaymentTransactionStateRestored: break;
    }
    
    return [NSDictionary dictionaryWithDictionary:luaDictionary];
}

@end
