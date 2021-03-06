//
//  Hero.m
//  SaintF
//
//  Created by Eliphas on 23.04.14.
//  Copyright (c) 2014 Eliphas. All rights reserved.
//

#import "Hero.h"
#import "AnimationHelper.h"
#import "MainGameLayer.h"
#import "BackgroundLayer.h"
#import "GameLogic.h"


static Hero* _sharedHero;

@interface Hero(){
    float winWidth;
    CCSprite* heroSprite;
    CCSpriteFrame* heroStands;
    CCSprite* commonAnimationSprite;
    FlowingAnimation* moveAnimation;
    float moveAnimationShift;
    
    MoveDirection currentDirection;
    bool isMoving; // check if we already moving and can't start moving
    bool shouldStopMoving; //when we stop touch
    float moveAnimationDelay;
    float scrollDistPerStep;
}
@end


@implementation Hero

-(id)init{
    if(self = [super init])
    {
        winWidth = [[CCDirector sharedDirector] winSize].width;
        moveAnimationShift = 100.0f;
        moveAnimationDelay = 0.5f;
        scrollDistPerStep = moveAnimationShift;
        
        [GameLogic sharedGameLogic].scrollSpeed = scrollDistPerStep / moveAnimationDelay;
        [self loadContent];
        [self buildAnimations];
    }
    return self;
}

-(void)loadContent {
    heroSprite = [CCSprite node];
    CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    heroStands = [frameCache spriteFrameByName:@"turn1.png"];
    [heroSprite setDisplayFrame:heroStands];
}

-(void) buildAnimations {
    CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    CCSpriteFrame* frame1 = [frameCache spriteFrameByName:@"move_new1.png"];
    CCSpriteFrame* frame2 = [frameCache spriteFrameByName:@"move_new2.png"];
    NSArray* moveFrames = [NSArray arrayWithObjects:frame1, frame2, nil];
    
    void (^callback)(CGPoint) = ^(CGPoint shift){
        [self animationMoveCallback:shift];
    };
    
    moveAnimation = [[FlowingAnimation alloc] initWithFrames:moveFrames delay:moveAnimationDelay callBack:callback];
    [heroSprite addChild:moveAnimation];
}

-(void)startMoving:(MoveDirection)direction {
    if(isMoving){
        return;
    }
    float scrollShift = scrollDistPerStep;
    currentDirection = direction;
    if(direction == LEFT ) {
        heroSprite.rotationY = 180;
        scrollShift = -scrollShift;
    }
    else {
        heroSprite.rotationY = 0;
    }
    
    [heroSprite setTextureRect:CGRectZero];
    float allowedShiftX = [self getShiftForDirection:direction];
    [moveAnimation startAnimationWithShift:ccp(allowedShiftX, 0.0f)];
    [[GameLogic sharedGameLogic] scrollBackgroundFor:scrollShift]; //start scrolling after starting animation
    isMoving = true;
    shouldStopMoving = false;
}

-(float) getShiftForDirection: (MoveDirection) direction {
    float distanceAllowed;
    if (direction == RIGHT) {
        distanceAllowed = [self getRightBorder] - self.position.x;
    }
    else {
        distanceAllowed = self.position.x - [self getLeftBorder];
    }
    if (moveAnimationShift < distanceAllowed) {
        return moveAnimationShift;
    }
    else {
        return distanceAllowed;
    }
}

-(void) animationMoveCallback: (CGPoint)shift {
    float moveDx = shift.x;
    float scrollShift = scrollDistPerStep;
    if(currentDirection == LEFT)
    {
        moveDx = -moveDx;
        scrollShift = -scrollShift;
    }
    
    CGPoint moveTo = ccpAdd(self.position, ccp(moveDx, shift.y));
    [self move:moveTo];
    if(shouldStopMoving)
    {
        [moveAnimation stopAnimation];
        isMoving = false;
        [heroSprite setTextureRect:[heroStands rect]];
    }else {
        //first we move, then calculate next possible shift
        float allowedShiftX = [self getShiftForDirection:currentDirection];
        [moveAnimation setShift:ccp(allowedShiftX, 0.0f)];
        [[GameLogic sharedGameLogic] scrollBackgroundFor: scrollShift]; //start new animation circle and scroll
        CCLOG(@"next shift allowedShiftX = %f", allowedShiftX);
    }
}

-(float) getRightBorder {
    return winWidth / 2.5;
}

-(float) getLeftBorder {
    return winWidth / 5;
}

-(void)stopMoving {
    shouldStopMoving = true;
}

-(void) move: (CGPoint) point {
    heroSprite.position = self.position = point;
}

-(void) spawnAtPosition:(CGPoint)position {
    MainGameLayer* mainGameLayer = [MainGameLayer sharedGameLayer];
    [mainGameLayer addChild:self];
    CCSpriteBatchNode* commonBatch = [mainGameLayer commonBatch];
    [commonBatch addChild:heroSprite];
    self.position = heroSprite.position = position;
}

-(CGSize) size
{
    return [heroSprite contentSize];
}

+(Hero*) sharedHero {
    if(!_sharedHero)
    {
        _sharedHero = [[Hero alloc] init];
    }
    return _sharedHero;
}

@end
