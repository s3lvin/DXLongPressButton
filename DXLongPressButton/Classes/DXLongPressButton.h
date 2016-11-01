//
//  LongPressButton.h
//  ButtonLongPress
//
//  Created by Selvin on 27/07/15.
//  Copyright (c) 2015 S3lvin. All rights reserved.
//

#import <UIKit/UIKit.h>


extern const UIControlEvents UIControlEventLongPress;

IB_DESIGNABLE
@interface DXLongPressButton : UIButton
/**
 *  Set this property to NO to allow other events to happen after long press event. 
 *  By default the value of this property is YES so that excessive events are cancelled.
 */
@property(nonatomic, assign, getter=shouldLongPressCancelOtherEvents)IBInspectable BOOL longPressCancelsOtherEvents;

/**
 *  The time interval of the long press. Default value is 1.0 second.
 */
@property(nonatomic, assign)IBInspectable CGFloat longPressInterval;

@end
