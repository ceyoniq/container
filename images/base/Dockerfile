# https://catalog.redhat.com/software/containers/ubi9/ubi-minimal/615bd9b4075b022acc111bf5
ARG baseImage=registry.access.redhat.com/ubi9/ubi-minimal:9.5-1731593028

FROM $baseImage

# see https://access.redhat.com/solutions/5616681
RUN \
     microdnf install --disablerepo=* --enablerepo=ubi-* --assumeyes tzdata-2024b-2.el9 \
  && microdnf clean all

