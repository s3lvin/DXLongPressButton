//
//  NSArray+DXFilter.m
//  ButtonLongPress
//
//  Created by Selvin on 03/08/15.
//  Copyright (c) 2015 S3lvin. All rights reserved.
//

#import "NSArray+DXFilter.h"

@implementation NSArray (DXFilter)

- (NSMutableArray *)filterObjectsMatchingPredicate:(BOOL (^)(id object))filterBlock {
    NSMutableArray *filteredArray = [NSMutableArray new];
    for (id item in self) {
        if (filterBlock(item)) {
            [filteredArray addObject:item];
        }
    }
    return filteredArray;
}

- (BOOL)removeObjectsMatchingPredicate:(BOOL (^)(id object))filterBlock {
    if (![self respondsToSelector:@selector(removeObject:)]) {
        return NO;
    }
    NSMutableArray *mutableSelf = (NSMutableArray *)self;
    NSMutableArray *filteredArray = [self filterObjectsMatchingPredicate:filterBlock];
    for (id obj in filteredArray) {
        [mutableSelf removeObject:obj];
    }
    return YES;
}

@end
