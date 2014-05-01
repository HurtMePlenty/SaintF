//
//  GUILayer.m
//  SaintF
//
//  Created by Alexey Semenov on 29/04/14.
//  Copyright 2014 Eliphas. All rights reserved.
//

#import "GUILayer.h"
#import "Hero.h"

static GUILayer* _sharedGUILayer;

@interface GUILayer() {
    
}

@end


@implementation GUILayer

-(id)init {
    if(self = [super init])
    {
        self.touchEnabled = true;
    }
    return self;
}

+(GUILayer*) sharedGUILayer {
    if(!_sharedGUILayer)
    {
        _sharedGUILayer = [[GUILayer alloc] init];
    }
    return _sharedGUILayer;
}

-(void) registerWithTouchDispatcher
{
    [[CCDirector sharedDirector].touchDispatcher addTargetedDelegate:self
                                                            priority:INT_MIN+1
                                                     swallowsTouches:YES];
}

-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    float fullWidth = [[CCDirector sharedDirector] winSize].width;
    MoveDirection direction;
    if(location.x < fullWidth / 2)
    {
        direction = LEFT;
    }
    else {
        direction = RIGHT;
    }
    [[Hero sharedHero] startMoving:direction];
    
    return YES;
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    [[Hero sharedHero] stopMoving];
}

-(void) ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event {
}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
}

@end
