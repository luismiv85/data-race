# data-race
docker build -t my-ruby-app .
docker run -it my-ruby-app /bin/bash
docker run -t -i -v /Users/luismivazquez/data-race/datas:/app/datas/ my-ruby-app /bin/bash

