# GoCD Agent Docker image

[GoCD agent](https://www.gocd.org) docker image based on AlmaLinux.


# Issues, feedback?

Please make sure to log them at https://github.com/gocd/gocd.

# Usage

Start the container with this:

```
docker run -d -e GO_SERVER_URL=... tecladozurdo/gocd-agent-alma:latest
```

This will start the GoCD agent and connect it the GoCD server specified by `GO_SERVER_URL`.

> **Note**: The `GO_SERVER_URL` must be an HTTPS url and end with `/go`, for e.g. `http://ip.add.re.ss:8153/go`

## Usage with docker GoCD server



# License

```plain
Copyright 2021 ThoughtWorks, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```


## BUILD DOCKER IMAGE
Luego para la construcción de la imagen:
```bash
docker build -t tecladozurdo/gocd-agent-alma:25.3.0 \
             -t tecladozurdo/gocd-agent-alma:latest .
```

### PUSH DOCKER IMAGE
Y para subirla a Docker Hub:
```bash
docker push tecladozurdo/gocd-agent-alma:25.3.0
docker push tecladozurdo/gocd-agent-alma:latest
```