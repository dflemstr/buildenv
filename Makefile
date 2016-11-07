CONFIGS := $(wildcard config/*.config)
IMAGE_TARGETS := $(notdir $(CONFIGS:.config=.image))

.DEFAULT: all

all: $(IMAGE_TARGETS)

%.image: config/%.config Dockerfile install install-meta
	docker build --build-arg target=$(@:.image=) -t dflemstr/buildenv:$(@:.image=) .
	docker push dflemstr/buildenv:$(@:.image=)
	touch $@
