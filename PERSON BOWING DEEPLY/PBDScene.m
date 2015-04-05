//
//  PBDScene.m
//  PERSON BOWING DEEPLY
//
//  Created by Matthew Pavlinsky on 4/5/15.
//  Copyright (c) 2015 Matthew Pavlinsky. All rights reserved.
//

#import "PBDScene.h"

#pragma mark -
#pragma mark Private

CGFloat randomFloat() {
    return (double)arc4random() / 0x100000000;
}

CGFloat timeScale = 1.0f;

////////////////////////////////////////////////////////////////////////////////////////////////////
@interface PBDScene ()

@property (nonatomic) CFTimeInterval nextCloudTime;

@end

////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation PBDScene

- (void)addRandomCloud {
    CGFloat cloudSize = randomFloat();
    CGFloat cloudY = (self.size.height * 0.7f * randomFloat()) + (self.size.height * 0.3f * cloudSize);
 
    SKLabelNode *$ = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    $.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    $.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    $.text = @"☁️";
    $.fontSize = 80 + (80 * cloudSize);
    $.position = CGPointMake(-(self.size.width * 0.25f), cloudY);
    $.alpha = 0.7f + (0.1f * randomFloat()) - (0.3f * cloudSize);
    [self addChild:$];
    
    [$ runAction:[SKAction sequence:@[
                                      [SKAction moveTo:CGPointMake(self.size.width * 1.25f, cloudY) duration:(30.0f + (5 * randomFloat()) + (5 * cloudSize)) * timeScale],
                                      [SKAction removeFromParent]]]];
}

-(void)didMoveToView:(SKView *)view {
    self.size = view.frame.size;

    SKTexture *backgroundTexture = [SKTexture textureWithImageNamed:@"Sky"];
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithTexture:backgroundTexture size:self.view.frame.size];
    background.position = (CGPoint) {CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame)};
    [self addChild:background];
}

//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    [self addRandomCloud];
//}

-(void)update:(CFTimeInterval)currentTime {
    if (self.nextCloudTime < currentTime) {
        self.nextCloudTime = currentTime + (1 + (10 * randomFloat())) * timeScale;
        [self addRandomCloud];
    }
}

@end
