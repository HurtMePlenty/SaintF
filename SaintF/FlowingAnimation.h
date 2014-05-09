//
//  FlowingAnimation.h
//  SaintF
//
//  Created by Alexey Semenov on 03/05/14.
//  Copyright (c) 2014 Eliphas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

typedef enum {
    LEFT,
    RIGHT
} MoveDirection;

@interface FlowingAnimation : CCSprite

-(id)initWithFrames: (NSArray*)frames delay:(float)delay callBack:(void(^)(void))delegate;
-(void) startAnimation: (MoveDirection)direction;
-(void) stopAnimation;

@end
