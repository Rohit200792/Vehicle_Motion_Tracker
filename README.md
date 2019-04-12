# MotionTracker
A matlab based motion tracker that identifies the moving objects in a video and segments them using morphological operators. The application can be used in vehicular motion recognition.

    % Motion_Tracker - segments moving objects in video
    % On input:
    %        vidObj (video object obtained by VideoReader): input video
    % On output:
    %       M (Matlab movie): movie of segmented moving objects
    % Call:
    %       vidObj = VideoReader(’../../../video.avi’);
    %       M = Motion_Tracker(vidObj);

Here are some example test cases:

%vidObj=VideoReader('.\video1.avi');

%vidObj=VideoReader('.\video2.avi');

%vidObj=VideoReader('.\video1.avi');
