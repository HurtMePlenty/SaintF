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

static Hero* _sharedHero;

@interface Hero(){
    CCSprite* heroSprite;
    CCSpriteFrame* heroStands;
    CCRepeatForever* moveAction;
    CCSprite* commonAnimationSprite;
    
    MoveDirection currentDirection;
    bool isMoving;
    float speed;
}
@end


@implementation Hero

-(id)init{
    if(self = [super init])
    {
        [self loadContent];
        [self scheduleUpdate];
        speed = 5.0f;
    }
    return self;
}

-(void)loadContent {
    heroSprite = [CCSprite node];
    CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    heroStands = [frameCache spriteFrameByName:@"hero_move1.png"];
    [heroSprite setDisplayFrame:heroStands];
}

-(void) buildAnimations {
    CCAnimation* animation = [CCAnimation animationWithFrame:@"hero_move" startFrameIndex:1 frameCount:2 delay:0.5f];
    CCAnimate* animate =[CCAnimate  actionWithAnimation:animation];
    moveAction = [CCRepeatForever actionWithAction:animate];
}

-(void)startMoving:(MoveDirection)direction {
    currentDirection = direction;
    [heroSprite setTextureRect:CGRectZero];
    [heroSprite runAction:moveAction];
}

-(void)stopMoving {
    [heroSprite stopAction:moveAction];
    [heroSprite setTextureRect:[heroStands rect]];
}

+(Hero*) sharedHero {
    if(!_sharedHero)
    {
        _sharedHero = [[Hero alloc] init];
    }
    return _sharedHero;
}

-(void)update:(ccTime)delta { //todo make lag insensetive
    self.position = ccpAdd(self.position, ccp(speed, 0.0f));
    heroSprite.position = self.position;
}

@end
