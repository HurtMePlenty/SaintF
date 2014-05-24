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
    int showingFrameIndex;
    
    CGPoint _shift;
    void(^_delegate)(CGPoint);
    
}

@end

@implementation FlowingAnimation

-(id)initWithFrames: (NSArray*)frames delay:(float)delay callBack:(void(^)(CGPoint))delegate {
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
    }
    return self;
}

-(void) startAnimationWithShift: (CGPoint)shift {
    [self setShift:shift];
    [self startAnimation];
}

-(void) setShift: (CGPoint) shift {
    sprite2.position = _shift = shift;
}

-(void) startAnimation {
    
    CCLOG(@"started");
    showingFrameIndex = 0;
    self.visible = true;
    [self nextFrame];
    [self scheduleUpdate];
}

-(void) stopAnimation {
    [self unscheduleUpdate];
    self.visible = false;
}

-(void) nextFrame {
    sprite1.displayFrame = [_frames objectAtIndex:showingFrameIndex];
    showingFrameIndex++;
    if(showingFrameIndex >= _frames.count) {
        showingFrameIndex = 0;
    }
    sprite2.displayFrame = [_frames objectAtIndex: showingFrameIndex];
    sprite1.opacity = 255;
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
    
    if(isOver) {
        if(_delegate){
            _delegate(_shift);
        }
        [self nextFrame];
    }
    
}

@end
