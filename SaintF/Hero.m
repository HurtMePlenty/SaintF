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
        [self buildAnimations];
        [self scheduleUpdate];
        speed = 1.0f;
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
    if(direction == LEFT ) {
        heroSprite.rotationY = 180;
    }
    else {
        heroSprite.rotationY = 0;
    }
    [heroSprite setTextureRect:CGRectZero];
    [heroSprite runAction:moveAction];
    isMoving = true;
}

-(void)stopMoving {
    [heroSprite stopAction:moveAction];
    [heroSprite setTextureRect:[heroStands rect]];
    isMoving = false;
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

-(void)update:(ccTime)delta { //todo make lag insensetive
    if(!isMoving){
        return;
    }
    float dx = speed;
    if(currentDirection == LEFT)
    {
        dx = -dx;
    }
    self.position = ccpAdd(self.position, ccp(dx, 0.0f));
    heroSprite.position = self.position;
}

@end
