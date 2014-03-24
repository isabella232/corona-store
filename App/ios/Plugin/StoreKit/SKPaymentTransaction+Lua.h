//
//  SKPaymentTransaction+Lua.h
//  Plugin
//
//  Created by Bruno Barbosa Pinheiro on 3/22/14.
//
//

#import <StoreKit/StoreKit.h>

@interface SKPaymentTransaction (Lua)

- (NSDictionary *) toLuaDictionary;

@end
