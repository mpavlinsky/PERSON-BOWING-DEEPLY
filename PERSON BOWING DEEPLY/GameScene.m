//
//  GameScene.m
//  PERSON BOWING DEEPLY
//
//  Created by Matthew Pavlinsky on 4/5/15.
//  Copyright (c) 2015 Matthew Pavlinsky. All rights reserved.
//

#import "GameScene.h"
//#import "NSNumber+CoolStuff.h"

#pragma mark -
#pragma mark Private

CGFloat randomFloat() {
    return (double)arc4random() / 0x100000000;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
@interface GameScene ()

@property (nonatomic) double nextCloudTime;

@property (nonatomic) CGPoint cloudStartPosition;
@property (nonatomic) CGPoint cloudEndPosition;

@end

////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation GameScene

- (void)addRandomCloud {
    
    CGFloat cloudY = self.size.height * randomFloat();
    
    /* Setup your scene here */
    SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    myLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    myLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    myLabel.text = @"☁️";
    myLabel.fontSize = 80 + (160 * randomFloat());
    myLabel.position = CGPointMake(-(self.size.width * 0.3f), cloudY);
    myLabel.alpha = 0.7f + 0.2 * randomFloat();
    [self addChild:myLabel];
    
    [myLabel runAction:[SKAction sequence:@[
                                            [SKAction moveTo:CGPointMake(self.size.width * 1.3f, cloudY) duration:30.0f + 5 * randomFloat()],
                                            [SKAction removeFromParent]]]];
}

- (void)testPosition:(CGPoint)position {
    SKLabelNode *myLabel2 = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    myLabel2.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    myLabel2.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    myLabel2.text = @"☁️";
    myLabel2.fontSize = 80 ;
    myLabel2.position = position;
    [self addChild:myLabel2];
}

-(void)didMoveToView:(SKView *)view {
    self.size = view.frame.size;

//    self.backgroundColor = [UIColor blueColor];
   
    SKTexture *backgroundTexture = [SKTexture textureWithImageNamed:@"Sky"];
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithTexture:backgroundTexture size:self.size];
    background.position = (CGPoint) {CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame)};
    [self addChild:background];
    
    
//    [self testPosition:CGPointMake(0,0)];
//    [self testPosition:CGPointMake(self.size.width, self.size.height)];
////    [self testPosition:CGPointMake(0,0)];
    
    
    //    self.cloudStartPosition = CGPointMake(, 0);
    self.cloudEndPosition = CGPointMake(self.size.width * 1.1f, self.size.height / 2);

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self addRandomCloud];
}

-(void)update:(CFTimeInterval)currentTime {
    if (currentTime > self.nextCloudTime) {
        self.nextCloudTime = currentTime + 1 + (10 * randomFloat());
        [self addRandomCloud];
    }
    /* Called before each frame is rendered */
}

@end
