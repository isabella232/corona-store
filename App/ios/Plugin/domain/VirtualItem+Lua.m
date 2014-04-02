//
//  VirtualItem+Lua.m
//  Plugin
//
//  Created by Bruno Barbosa Pinheiro on 3/13/14.
//
//

#import "VirtualItem+Lua.h"

#define kVirtualItem_Name           @"name"
#define kVirtualItem_Description    @"description"
#define kVirtualItem_ItemId         @"itemId"
#define kVirtualItem_Class          @"class"

@implementation VirtualItem (Lua)

- (id) initFromLua:(NSDictionary *) luaData {
    self = [super init];
    if(self == nil) return nil;
    
    self.name = [luaData objectForKey:kVirtualItem_Name];
    self.description = [luaData objectForKey:kVirtualItem_Description];
    
    NSString * identification = [luaData objectForKey:kVirtualItem_ItemId];
    if([identification isEqualToString:@""] || [identification isKindOfClass:[NSNull class]] || identification == nil) {
        NSLog(@"SOOMLA: %@ can't be null! The Virtual Item won't be created.",kVirtualItem_ItemId);
        return nil;
    }
    self.itemId = identification;
    
    return self;
}

- (NSDictionary *) toLuaDictionary {
    return @{
             kVirtualItem_Class : NSStringFromClass([self class]),
             kVirtualItem_Name : self.name,
             kVirtualItem_Description : self.description,
             kVirtualItem_ItemId : self.itemId
    };
}

@end
