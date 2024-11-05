//
//  BirdShader.metal
//  FlappyBird-Learn
//
//  Created by Nathan on 8/8/24.
//

#include <metal_stdlib>
using namespace metal;

/* NOTES:
 - this file allows for graphics programming, i.e., talking directly to the GPU for direct pixel manipulation
 - feel free to customize as you need; I recommend tutorials to learn Metal
 - Here's a good starting point: https://www.youtube.com/watch?v=EgzWwgRpUuw
 - in case the link doesn't work, the video is called: SwiftUI + Metal - Create special effects by building your own shaders
 - The YouTuber is: Paul Hudson
 */

// checks if the pixel color of a given pixel on the bird image is close to a target color, in this case yellow rgb(254, 204, 58) and if so, changes it to a new color of choice
// dividing by 255 in each coordinate because Swift uses a scale from 0-1 instead of 0-255
[[ stitchable ]] half4 colorBird(float2 position, half4 color, half4 newColor) {
    half3 targetColor = half3(254 / 255, 204 / 255, 58 / 255);
    half colorDistance = distance(color.rgb, targetColor);
    
    half threshold = 0.05; // if the actual color is within a small range of the target color, change the pixel's color to the new color
    
    if (colorDistance < threshold) {
        return half4(newColor.rgb * color.a, color.a);
    }
    
    return color;
}
