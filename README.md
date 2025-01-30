This was my test task.

"Flutter"  
Create a page for customization of payment card. User should able to:
⁃ set background image of card; user should choose an image from device’s external storage or choose among predefined images;
⁃ User can scale background image with pinch zoom or drag gesture directly inside card
⁃ By default, one of the predefined images should be selected randomly;   
⁃ setup background color/gradient of card with color picker (can use color picker libraries);
⁃ User can select only background image or color at the same time;
⁃ set blur overlay with adjustable blurry degree;
⁃ When clicked ‘Save’ button, all the changes image/color/gradient, blur degree should send to remote (mock).
⁃ All the data should be sent with multipart method. Image should be compressed;
⁃ Use bloc or provider pattern;
⁃ Use only official flutter packages, do not use third party packages beside color picker library.

remote api is not implemented due to time limit.

Currently 
1. you can select image from external storage
2. select predefined image
3. select color
4. save custom card
5. scale up and down the image

Demo
[demo.MP4](assets%2Fdemo.MP4)