//
//  NSDictionary+CreateFromLua.h
//  Plugin
//
//  Created by Bruno Barbosa Pinheiro on 3/7/14.
//
//

#import <Foundation/Foundation.h>
#import "CoronaLua.h"

@interface NSDictionary (CreateFromLua)

+ (NSDictionary *) dictionaryFromLua:(lua_State *) L tableIndex:(int) tableIndex;

@end
