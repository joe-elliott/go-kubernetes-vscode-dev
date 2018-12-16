FROM golang

ENV GOPATH=/opt/go:$GOPATH \
    PATH=/opt/go/bin:$PATH

# snag delve and dep
RUN go get github.com/derekparker/delve/cmd/dlv && \
    curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh
    

WORKDIR /opt/go/src/local/myorg/myapp 

CMD ["bash"]