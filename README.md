# data-race

docker build -t data-race-script .
docker run -it data-race-script /bin/bash
docker run -t -i -v /Users/luismivazquez/data-race/datas:/app/datas/ data-race-script /bin/bash

