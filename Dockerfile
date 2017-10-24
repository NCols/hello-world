# explicitly use Debian for maximum cross-architecture compatibility
FROM cloudron/base:0.11.0

RUN dpkg --add-architecture i386

WORKDIR /app/code/hello
COPY . .

RUN set -ex; \
	make clean all test \
		TARGET_ARCH='amd64' \
		CC='x86_64-linux-gnu-gcc' \
		STRIP='x86_64-linux-gnu-strip'

RUN set -ex; \
	make clean all \
		TARGET_ARCH='arm32v5' \
		CC='arm-linux-gnueabi-gcc' \
		STRIP='arm-linux-gnueabi-strip'

RUN set -ex; \
	make clean all \
		TARGET_ARCH='arm32v7' \
		CC='arm-linux-gnueabihf-gcc' \
		STRIP='arm-linux-gnueabihf-strip'

RUN set -ex; \
	make clean all \
		TARGET_ARCH='arm64v8' \
		CC='aarch64-linux-gnu-gcc' \
		STRIP='aarch64-linux-gnu-strip'

RUN set -ex; \
	make clean all test \
		TARGET_ARCH='i386' \
		CC='gcc -m32 -L/usr/lib/gcc/i686-linux-gnu/6' \
		STRIP='x86_64-linux-gnu-strip'

RUN set -ex; \
	make clean all \
		TARGET_ARCH='ppc64le' \
		CC='powerpc64le-linux-gnu-gcc' \
		STRIP='powerpc64le-linux-gnu-strip'

RUN set -ex; \
	make clean all \
		TARGET_ARCH='s390x' \
		CC='s390x-linux-gnu-gcc' \
		STRIP='s390x-linux-gnu-strip'

RUN find \( -name 'hello' -or -name 'hello.txt' \) -exec file '{}' + -exec ls -lh '{}' +

CMD ["./amd64/hello-world/hello"]
