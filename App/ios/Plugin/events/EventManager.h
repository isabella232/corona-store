//
//  EventManager.h
//  Plugin
//
//  Created by Bruno Barbosa Pinheiro on 3/21/14.
//
//

#import <Foundation/Foundation.h>
#import "CoronaLua.h"

@interface EventManager : NSObject

@property (nonatomic,strong) NSDictionary * events;

+ (EventManager *) sharedInstance;
- (void) addListener:(CoronaLuaRef) listener toEvent:(NSString *) eventName;
- (void) removeListener:(CoronaLuaRef) listener fromEvent:(NSString *) eventName;
- (void) deleteAllReferences:(lua_State *) L;

@end
