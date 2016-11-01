//
//  NSArray+DXFilter.h
//  ButtonLongPress
//
//  Created by Selvin on 03/08/15.
//  Copyright (c) 2015 S3lvin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (DXFilter)

- (NSMutableArray *)filterObjectsMatchingPredicate:(BOOL (^)(id object))filterBlock;

- (BOOL)removeObjectsMatchingPredicate:(BOOL (^)(id object))filterBlock;

@end
