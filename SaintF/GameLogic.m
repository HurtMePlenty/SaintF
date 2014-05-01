//
//  LevelBuilder.m
//  SaintF
//
//  Created by Alexey Semenov on 27/04/14.
//  Copyright (c) 2014 Eliphas. All rights reserved.
//

#import "GameLogic.h"
#import "MainGameLayer.h"
#import "Hero.h"


@implementation GameLogic

+(void) buildLevel {
    Hero* hero = [Hero sharedHero];
    CGSize heroSize = [hero size];
    float spawnX = heroSize.width / 2;
    float spawnY = heroSize.height / 2;
    CGPoint spawnPosition = ccp(spawnX, spawnY);
    [hero spawnAtPosition:spawnPosition];
}

@end
