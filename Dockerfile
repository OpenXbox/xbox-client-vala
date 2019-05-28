FROM elementary/docker:stable

### Install dependencies
RUN apt -y update
RUN apt -y install \
	libglib2.0-dev \
	libjson-glib-dev \
	libsoup2.4-dev \
	libgee-0.8-dev \
	libvala-0.40-dev \
	libwebkit2gtk-4.0-dev \
	libgranite-dev \
	valac

### Copy current workdir
COPY . /app

WORKDIR /app
### Build app
RUN rm -rf build
RUN meson build

WORKDIR /app/build
### Test app
RUN ninja test

CMD ["/app/build/com.github.gffranco.OpenXboxClient"]
