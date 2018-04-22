#import "ViewController.h"
#import "AAPLRenderer.h"

@implementation ViewController
{
    MTKView *_view;
    
    AAPLRenderer *_renderer;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // set the view to use the default device
    _view = (MTKView *)self.view;
    _view.device = MTLCreateSystemDefaultDevice();
    if (!_view.device)
        NSLog(@"Metal is not supported!");
    
    _renderer = [[AAPLRenderer alloc] initWithMetalKitView:_view];
    if (!_renderer)
        NSLog(@"Renderer failed initialization");
    
    _view.delegate = _renderer;
    
    //indicate that we would like the view to call our -[AAPLRender drawInMTKView:] 60 times per second
    _view.preferredFramesPerSecond = 60;
}

@end
