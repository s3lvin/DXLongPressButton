//
//  LongPressButton.m
//  ButtonLongPress
//
//  Created by Selvin on 27/07/15.
//  Copyright (c) 2015 S3lvin. All rights reserved.
//

#import "DXLongPressButton.h"
#import "NSArray+DXFilter.h"

const UIControlEvents UIControlEventLongPress = 1 << 9;

#define kDefaultTimeInterval 1.0

@interface DXLongPressButton () {
    BOOL _isPressed;
    UIEvent *_touchEvent;
    NSMutableArray *_targetActionArray;
}

@end

/**
 *  We need this wrapper to hold weak references of targets
 */
@interface DXTargetActionProxy : NSProxy

@property(nonatomic, weak) id dxtarget;
@property(nonatomic, assign) SEL dxaction;

@end

@implementation DXTargetActionProxy

@end

@implementation DXLongPressButton

- (instancetype)init {
    if (self = [super init]) {
        [self initializeIvars];
        [self addLongPressActions];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initializeIvars];
        [self addLongPressActions];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initializeIvars];
        [self addLongPressActions];
    }
    return self;
}

- (void)dealloc {
    [self removeLongpressActions];
}

- (void)initializeIvars {
    _longPressInterval = kDefaultTimeInterval;
    _targetActionArray = [NSMutableArray new];
    _longPressCancelsOtherEvents = YES;
}

- (void)addLongPressActions {
    [super addTarget:self action:@selector(buttonTouchedUp:event:) forControlEvents:UIControlEventTouchUpInside];
    [super addTarget:self action:@selector(buttonTouchDown:event:) forControlEvents:UIControlEventTouchDown];
    [super addTarget:self action:@selector(buttonTouchCanceled:) forControlEvents:UIControlEventTouchDragExit |
                                                                                  UIControlEventTouchCancel];
}

- (void)removeLongpressActions {
    [super removeTarget:self action:@selector(buttonTouchedUp:event:) forControlEvents:UIControlEventTouchUpInside];
    [super removeTarget:self action:@selector(buttonTouchDown:event:) forControlEvents:UIControlEventTouchDown];
    [super removeTarget:self action:@selector(buttonTouchCanceled:) forControlEvents:UIControlEventTouchDragExit |
                                                                                     UIControlEventTouchCancel];
}

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    if (controlEvents & UIControlEventLongPress) {
        target = [self responderForTarget:target Withaction:action];
        DXTargetActionProxy *targetAction = [DXTargetActionProxy alloc];
        targetAction.dxtarget = target;
        targetAction.dxaction = action;
        [_targetActionArray addObject:targetAction];
    }
    [super addTarget:target action:action forControlEvents:controlEvents];
}

- (void)removeTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    if (controlEvents & UIControlEventLongPress) {
        [self removeTargetAction:action];
    }
    [super removeTarget:target action:action forControlEvents:controlEvents];
}

- (void)removeTargetAction:(SEL)action {
    [_targetActionArray removeObjectsMatchingPredicate:^BOOL(DXTargetActionProxy *object) {
        return object.dxaction == action;
    }];
}

- (UIResponder*)responderForTarget:(UIResponder*)target Withaction:(SEL)action {
    // walk up the responder chain if you have to
    UIResponder *responder = target?:[self nextResponder];
    while (responder) {
        if ([responder respondsToSelector:action]) {
            break;
        }
        responder = [responder nextResponder];
    }
    return responder;
}

#pragma mark - longpress handlers

- (void)buttonTouchedUp:(UIButton *)sender event:(UIEvent *)event {
    _isPressed = NO;
    [NSObject cancelPreviousPerformRequestsWithTarget:sender];
}

- (void)buttonTouchDown:(UIButton *)sender event:(UIEvent *)event {
    _isPressed = YES;
    _touchEvent = event;
    [self performSelector:@selector(touchedAndHeldForLongTime:)
               withObject:self
               afterDelay:self.longPressInterval];
}

- (void)buttonTouchCanceled:(UIButton *)sender {
    _isPressed = NO;
    [NSObject cancelPreviousPerformRequestsWithTarget:sender];
}

- (void)touchedAndHeldForLongTime:(UIButton *)sender {
    if (_isPressed) {
        for (DXTargetActionProxy *targetAction in _targetActionArray) {
            if (targetAction.dxtarget) {
                NSMethodSignature *theSignature = [targetAction.dxtarget methodSignatureForSelector:targetAction.dxaction];
                NSInvocation *theInvocation = [NSInvocation invocationWithMethodSignature:theSignature];
                [theInvocation setTarget:targetAction.dxtarget];
                [theInvocation setSelector:targetAction.dxaction];
                NSUInteger argumentCount = [theSignature numberOfArguments] - 2;
                // support all 3 types of event handler signatures
                for (int i = 0; i < argumentCount; ++i) {
                    if (i == 0) {
                        [theInvocation setArgument:&sender atIndex:(i + 2)];
                    } else if (i == 1) {
                        [theInvocation setArgument:&_touchEvent atIndex:(i + 2)];
                    } else {
                        void *nilParam = NULL;
                        [theInvocation setArgument:&nilParam atIndex:(i + 2)];
                    }
                }
                [theInvocation invoke];
            }
        }
        if (self.shouldLongPressCancelOtherEvents) {
            [self cancelTrackingWithEvent:nil];
        }
    }
}

@end
