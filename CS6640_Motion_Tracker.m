function M = CS6640_Motion_Tracker(vidObj)
% CS6640_Motion_Tracker - segments moving objects in video
% On input:
%        vidObj (video object obtained by VideoReader): input video
% On output:
%       M (Matlab movie): movie of segmented moving objects
% Call:
%       vidObj = VideoReader(’../../../video.avi’);
%       M = CS6640_Motion_Tracker(vidObj);
% Author:
%       Rohit Singh
%       Fall 2018
%       UU
%

%background and frame extraction from video
video=vidObj;
nFrames=video.NumberOfFrames;
frames=rgb2gray(read(video,1));
bImage= zeros(size(frames));
for i = 1:nFrames;
    frames(:,:,i)=rgb2gray(read(video,i));    
    bImage = bImage + double(frames(:,:,i));
end;
bImageMean = mat2gray(bImage/nFrames);
diffFrames=zeros(size(frames));

%grayscale difference images
for i = 1:nFrames;
    diffFrames(:,:,i)=abs(abs(mat2gray(frames(:,:,i))-bImageMean).^0.8);    
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%To remove stationary patches from segmented images

bImage= zeros(size(diffFrames(:,:,1)));
for i = 1:nFrames;    
    bImage = bImage + diffFrames(:,:,1);
end;
bImageMean = bImage/nFrames;
for i = 1:nFrames;
    diffFrames(:,:,i)=diffFrames(:,:,i)-bImageMean;    
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%convertimg to bw with custom threshold
thresh=[];
for i=1:nFrames;
    thresh=[thresh graythresh(diffFrames(:,:,i))];
end;
threshmax=max(thresh);
threshmin=min(thresh);

for i=1:nFrames;       
      diffFramesBW(:,:,i)=im2bw(diffFrames(:,:,i),2*threshmax/3); 
end;

for i=1:nFrames 
  I=255*diffFramesBW(:,:,i);
  map=colormap(gray(256));
  movBW(i) = im2frame(uint8(I),map);
end;
M=movBW;

%vidObj=VideoReader('C:\Users\Rohit Singh\OneDrive\MSCS\CS6640 Image
%Processing\Assignments\A4\Videos\video1.avi');

%vidObj=VideoReader('C:\Users\Rohit Singh\OneDrive\MSCS\CS6640 Image
%Processing\Assignments\A4\Videos\video2.avi');

%vidObj=VideoReader('C:\Users\Rohit Singh\OneDrive\MSCS\CS6640 Image
%Processing\Assignments\A4\Videos\video1.avi');