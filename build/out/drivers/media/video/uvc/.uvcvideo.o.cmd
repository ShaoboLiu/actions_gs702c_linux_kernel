cmd_drivers/media/video/uvc/uvcvideo.o := /opt/arm-2011.09/bin/arm-none-linux-gnueabi-ld -EL    -r -o drivers/media/video/uvc/uvcvideo.o drivers/media/video/uvc/uvc_driver.o drivers/media/video/uvc/uvc_queue.o drivers/media/video/uvc/uvc_v4l2.o drivers/media/video/uvc/uvc_video.o drivers/media/video/uvc/uvc_ctrl.o drivers/media/video/uvc/uvc_status.o drivers/media/video/uvc/uvc_isight.o drivers/media/video/uvc/uvc_debugfs.o ; scripts/mod/modpost drivers/media/video/uvc/uvcvideo.o
