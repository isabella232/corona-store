//
//  SoomlaStore.m
//  Soomla for Corona
//
//  Created by Bruno Barbosa Pinheiro on 3/7/14.

#import "SoomlaStore.h"

@implementation SoomlaStore

+ (SoomlaStore *) sharedInstance {
    static SoomlaStore * instance = nil;
    if(instance == nil) instance = [[SoomlaStore alloc] init];
    return instance;
}

@end
