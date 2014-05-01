//
//  Hero.h
//  SaintF
//
//  Created by Eliphas on 23.04.14.
//  Copyright (c) 2014 Eliphas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

typedef enum {
    LEFT,
    RIGHT
} MoveDirection;

@interface Hero : CCNode

-(void) startMoving: (MoveDirection)direction;
-(void) stopMoving;
-(void) spawnAtPosition:(CGPoint)position;
-(CGSize) size;

+(Hero*) sharedHero;

@end
