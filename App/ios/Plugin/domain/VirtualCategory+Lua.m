//
//  VirtualCategory+Lua.m
//  Plugin
//
//  Created by Bruno Barbosa Pinheiro on 3/13/14.
//
//

#import "VirtualCategory+Lua.h"

#define kVirtualCategory_Name       @"name"
#define kVirtualCategory_Items      @"items"

@implementation VirtualCategory (Lua)

- (id) initFromLua:(NSDictionary *)luaData {
    
    self = [super init];
    if(self == nil) return nil;
    
    self.name = [luaData objectForKey:kVirtualCategory_Name];
    
    NSDictionary * itemsData = [luaData objectForKey:kVirtualCategory_Items];
    NSEnumerator * itemsEnumerator = [itemsData objectEnumerator];
    id obj;
    NSMutableArray * items = [[NSMutableArray alloc] init];
    while(obj = [itemsEnumerator nextObject]) {
        if([obj isKindOfClass:[NSString class]]) [items addObject:obj];
        else NSLog(@"SOOMLA: %@ is not a valid itemId (string)",obj);
    }
    self.goodsItemIds = [NSArray arrayWithArray:items];
    
    return self;
}

@end
