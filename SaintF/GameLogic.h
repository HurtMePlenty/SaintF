//
//  GameLogic.h
//  SaintF
//
//  Created by Alexey Semenov on 03/05/14.
//  Copyright (c) 2014 Eliphas. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    bush,
    klen,
    oak,
    platan,
    yasen
    
} BackgroundObjects;

@interface GameLogic : NSObject

-(void) scrollBackgroundFor:(float)length;
-(void) buildInitialBackground;

+(GameLogic*) sharedGameLogic;

@end
