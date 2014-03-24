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
        case SKPaymentTransactionStateFailed:
            [luaDictionary setValue:@"failed" forKey:@"state"];
            [luaDictionary setValue:[NSNumber numberWithInteger:self.error.code] forKey:@"errorCode"];
            [luaDictionary setValue:self.error.domain forKey:@"errorDomain"];
            [luaDictionary setValue:self.error.description forKey:@"errorDescription"];
            break;
        
        case SKPaymentTransactionStatePurchased:
            //IMPORTANT: Receipt is deprecated
            [luaDictionary setValue:@"purchased" forKey:@"state"];
            [luaDictionary setValue:[NSString stringWithFormat:@"%@",self.transactionDate] forKey:@"date"];
            [luaDictionary setValue:self.transactionIdentifier forKey:@"transactionIdentifier"];
            break;
        
        case SKPaymentTransactionStatePurchasing:
            
            break;
        
        case SKPaymentTransactionStateRestored:
            [luaDictionary setValue:@"restored" forKey:@"state"];
            [luaDictionary setValue:[NSString stringWithFormat:@"%@",self.transactionDate] forKey:@"date"];
            [luaDictionary setValue:[self.originalTransaction toLuaDictionary] forKey:@"originalTransaction"];
            [luaDictionary setValue:self.transactionIdentifier forKey:@"transactionIdentifier"];
            break;
    }
    
    [luaDictionary setValue:self.payment.productIdentifier forKey:@"productId"];
    [luaDictionary setValue:[NSNumber numberWithInteger:self.payment.quantity] forKey:@"quantity"];
    
    return [NSDictionary dictionaryWithDictionary:luaDictionary];
}

@end
