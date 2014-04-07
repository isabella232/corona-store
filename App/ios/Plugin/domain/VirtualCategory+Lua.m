//
//  VirtualCategory+Lua.m
//  Plugin
//
//  Created by Bruno Barbosa Pinheiro on 3/13/14.
//
//

#import "VirtualCategory+Lua.h"
#import "NSArray+Lua.h"

#define kVirtualCategory_Name       @"name"
#define kVirtualCategory_Items      @"items"

@implementation VirtualCategory (Lua)

- (id) initFromLua:(NSDictionary *)luaData {
    
    self = [super init];
    if(self == nil) return nil;
    
    NSString * categoryName = [luaData objectForKey:kVirtualCategory_Name];
    if([categoryName isEqualToString:@""] || [categoryName isKindOfClass:[NSNull class]] || categoryName == nil) {
        NSLog(@"SOOMLA: %@ can't be null for Category.",kVirtualCategory_Name);
        return nil;
    }
    
    self.name = categoryName;
    
    NSDictionary * itemsData = [luaData objectForKey:kVirtualCategory_Items];
    if(itemsData == nil || [itemsData count] <= 0) {
        NSLog(@"SOOMLA: %@ doesn't contain any item.",self.name);
        return nil;
    }
    self.goodsItemIds = [itemsData allValues];
    
    return self;
}

- (NSDictionary *) toLuaDictionary {
    return @{
        kVirtualCategory_Name : self.name,
        kVirtualCategory_Items : self.goodsItemIds
    };
}

@end
