// #import <Foundation/Foundation.h>

@import simd;
@import MetalKit;

#import "AAPLRenderer.h"

// main class performing the rendering
@implementation AAPLRenderer
{
    id<MTLDevice> _device;
    id<MTLCommandQueue> _commandQueue;
}

typedef struct {
    float red, green, blue, alpha;
} Color;

// initialize with the MetalKit view from which we'll obrain our Metal device. We'll also use this
// mtkView object to set the pixel format and other properties of our drawable
- (nonnull instancetype)initWithMetalKitView:(nonnull MTKView *)mtkView
{
    self = [super init];
    if (self)
    {
        _device = mtkView.device;
        _commandQueue = [_device newCommandQueue];
    }
    
    return self;
}

#pragma mark - MTKViewDelegate methods

- (void)drawInMTKView:(nonnull MTKView *)view
{
    // Color color =
    // view.clearColor = MTLClearColorMake(color.red, color.green, color.blue, color.alpha);
    view.clearColor = MTLClearColorMake(0.2, 0.5, 0.9, 1.0);
    
    // create a new command buffer for each render pass to the current drawable
    id<MTLCommandBuffer> commandBuffer = [_commandQueue commandBuffer];
    commandBuffer.label = @"MyCommand";
    
    // obtain a render pass descriptor, generated from the view's drawable
    MTLRenderPassDescriptor *renderPassDescriptor = view.currentRenderPassDescriptor;
    
    // if you've successfully obtained a render pass descriptor, you can render to
    // the drawable; otherwise you skip any rendering this frame because you have no
    // drawable to draw to
    if (renderPassDescriptor != nil)
    {
        id<MTLRenderCommandEncoder> renderEncoder = [commandBuffer renderCommandEncoderWithDescriptor:renderPassDescriptor];
        renderEncoder.label = @"MyRenderEncoder";
        
        // we would normally use the render command encoder to draw our objects, but for
        //      the pursposes of this sample, all we need is the GPU clear command that
        //      Metal implicitly performs when we create the encoder
        
        // since we aren't drawing anything, idicate we're finished using this encoder
        [renderEncoder endEncoding];
        
        // add a final command to present the cleared drawable to the screen
        [commandBuffer presentDrawable:view.currentDrawable];
    }
    //finalize rendering here and submit the command buffer to the GPU
    [commandBuffer commit];
}

// called whenevere the view size changes
- (void)mtkView:(MTKView *)view drawableSizeWillChange:(CGSize)size
{
    
}

@end
