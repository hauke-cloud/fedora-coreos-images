FROM nginx:alpine

# Accept BUILD_DIR as a build argument
ARG BUILD_DIR
ARG ARCH

# Copy files specific to the architecture
COPY ${BUILD_DIR}/${ARCH}/latest-live-initramfs.${ARCH}.img /usr/share/nginx/html/initramfs.img
COPY ${BUILD_DIR}/${ARCH}/latest-live-kernel-${ARCH} /usr/share/nginx/html/kernel
COPY ${BUILD_DIR}/${ARCH}/latest-live-rootfs.${ARCH}.img /usr/share/nginx/html/rootfs.img
