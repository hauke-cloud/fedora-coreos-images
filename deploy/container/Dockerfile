FROM nginx:alpine

# Accept BUILD_DIR as a build argument
ARG BUILD_DIR

# Copy files specific to the architecture
COPY ${BUILD_DIR}/latest-live-initramfs.*.img /usr/share/nginx/html/initramfs.img
COPY ${BUILD_DIR}/latest-live-kernel-* /usr/share/nginx/html/kernel
COPY ${BUILD_DIR}/latest-live-rootfs.*.img /usr/share/nginx/html/rootfs.img
