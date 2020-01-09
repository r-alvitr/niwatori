set -eux; \
  ARCH="$(dpkg --print-architecture)"; \
  case "${ARCH}" in \
  armhf) \
  ESUM='c6b1fda3f8807028cbfcc34a4ded2e8a5a6b6239d2bcc1f06673ea6b1530df94'; \
  BINARY_URL='https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.5%2B10/OpenJDK11U-jdk_arm_linux_hotspot_11.0.5_10.tar.gz'; \
  ;; \
  ppc64el|ppc64le) \
  ESUM='d763481ddc29ac0bdefb24216b3a0bf9afbb058552682567a075f9c0f7da5814'; \
  BINARY_URL='https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.5%2B10/OpenJDK11U-jdk_ppc64le_linux_hotspot_11.0.5_10.tar.gz'; \
  ;; \
  amd64|x86_64) \
  ESUM='6dd0c9c8a740e6c19149e98034fba8e368fd9aa16ab417aa636854d40db1a161'; \
  BINARY_URL='https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.5%2B10/OpenJDK11U-jdk_x64_linux_hotspot_11.0.5_10.tar.gz'; \
  ;; \
  *) \
  echo "Unsupported arch: ${ARCH}"; \
  exit 1; \
  ;; \
  esac; \
  curl -LfsSo /tmp/openjdk.tar.gz ${BINARY_URL}; \
  echo "${ESUM} */tmp/openjdk.tar.gz" | sha256sum -c -; \
  mkdir -p /opt/java/openjdk; \
  cd /opt/java/openjdk; \
  tar -xf /tmp/openjdk.tar.gz --strip-components=1; \
  rm -rf /tmp/openjdk.tar.gz;
