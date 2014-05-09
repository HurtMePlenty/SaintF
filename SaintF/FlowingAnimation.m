//
//  FlowingAnimation.m
//  SaintF
//
//  Created by Alexey Semenov on 03/05/14.
//  Copyright (c) 2014 Eliphas. All rights reserved.
//

#import "FlowingAnimation.h"

@interface FlowingAnimation() {
    NSArray* _frames;
    float _delay;

    
    CCSprite* sprite1;
    CCSprite* sprite2;
    float _frameDist;
    void(^_delegate)(void);
    
}

@end

@implementation FlowingAnimation

-(id)initWithFrames: (NSArray*)frames delay:(float)delay callBack:(void(^)(void))delegate {
    if(self = [super init])
    {
        _frames = frames;
        _delay = delay;
        _delegate = delegate;
        
        self.textureRect = CGRectZero;
        sprite1 = [[CCSprite alloc]init];
        sprite2 = [[CCSprite alloc] init];
        
        [self addChild:sprite1];
        [self addChild:sprite2];
        self.visible = false;
        [self setInitialFrames];
    }
    return self;
}

-(void) startAnimation:(MoveDirection)direction {
    
    CCLOG(@"started");
    [self setInitialFrames];
    if(direction == LEFT)
    {
        sprite1.rotationY = 180;
        sprite2.rotationY = 180;
    }
    else {
        sprite1.rotationY = 0;
        sprite2.rotationY = 0;
    }
    
    self.visible = true;
    [self scheduleUpdate];
    
}

-(void) setInitialFrames {
    sprite1.displayFrame = [_frames objectAtIndex:0];
    sprite2.displayFrame = [_frames objectAtIndex:1];
    sprite1.opacity = 255;
    sprite2.opacity = 0;
}

-(void) stopAnimation {
    [self setInitialFrames];
    [self unscheduleUpdate];
    self.visible = false;
}

-(void) swapFrames {
    CCSprite* swap;
    swap = sprite1;
    sprite1 = sprite2;
    sprite2 = swap;
    sprite1.opacity = 255; //should be fine anyway, just to make sure
    sprite2.opacity = 0;
}

-(void) update:(ccTime)delta{
    float passedPart = delta / _delay;
    float maxOpacity = 255;
    float opacityChange = maxOpacity * passedPart;
    
    //do not call opacity setter one more time - too expensive ^^
    
    float opacity1 = sprite1.opacity;
    float opacity2 = sprite2.opacity;
    
    
    opacity1 -= opacityChange;
    opacity2 += opacityChange;
    
    bool isOver = false;
    
    if(opacity1 < 0 || opacity2 > 255) {
        opacity1 = 0;
        opacity2 = 255;
        isOver = true;
        
    }
    sprite1.opacity = opacity1;
    sprite2.opacity = opacity2;
    
    opacity2 = sprite2.opacity;
    CCLOG(@"%f", opacity2);
    
    if(isOver) {
        if(_delegate){
            _delegate();
        }
        [self swapFrames];
    }
    
}

@end
