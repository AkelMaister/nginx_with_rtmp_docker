# Nginx with rtmp-module

Live streaming and transcoding video server

## Usage

### Exaple
```
docker run -i -t akel/nginx_with_rtmp_docker
```

### Publish URL
Set your RTMP encoder to publish to rtmp://{your-server}/live/{your-stream-name}

### Transcoding streams
You can get transcoded streams from:
rtmp://{your-server}/live720p/{your-stream-name} for get 720p stream
rtmp://{your-server}/live480p/{your-stream-name} for get 480p stream
rtmp://{your-server}/live360p/{your-stream-name} for get 360p stream
