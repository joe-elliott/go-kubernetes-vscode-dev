FROM golang

ENV GOPATH=/opt/go:$GOPATH \
    PATH=/opt/go/bin:$PATH

# snag delve
RUN go get github.com/derekparker/delve/cmd/dlv

# copy binary in
ADD . /opt/go/src/local/myorg/myapp
WORKDIR /opt/go/src/local/myorg/myapp 

CMD ["bash"]